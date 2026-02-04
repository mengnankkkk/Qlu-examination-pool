// 表单验证脚本

// 验证规则
const validationRules = {
    username: {
        required: true,
        minLength: 3,
        maxLength: 20,
        pattern: /^[a-zA-Z0-9_]+$/,
        message: '用户名必须为3-20个字符，只能包含字母、数字和下划线'
    },
    password: {
        required: true,
        minLength: 6,
        maxLength: 20,
        pattern: /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]+$/,
        message: '密码必须为6-20个字符，且包含字母和数字'
    },
    confirmPassword: {
        required: true,
        match: 'password',
        message: '两次输入的密码不一致'
    },
    email: {
        required: true,
        pattern: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
        message: '请输入有效的邮箱地址'
    },
    gender: {
        required: true,
        message: '请选择性别'
    },
    region: {
        required: true,
        message: '请选择地区'
    }
};

// 显示错误信息
function showError(input, message) {
    const formGroup = input.parentElement;
    formGroup.classList.remove('success');
    formGroup.classList.add('error');
    
    const errorDiv = formGroup.querySelector('.error-message');
    if (errorDiv) {
        errorDiv.textContent = message;
    }
}

// 显示成功状态
function showSuccess(input) {
    const formGroup = input.parentElement;
    formGroup.classList.remove('error');
    formGroup.classList.add('success');
}

// 清除状态
function clearStatus(input) {
    const formGroup = input.parentElement;
    formGroup.classList.remove('error', 'success');
}

// 验证单个字段
function validateField(input) {
    const fieldName = input.name;
    const value = input.value.trim();
    const rules = validationRules[fieldName];
    
    if (!rules) return true;
    
    // 必填验证
    if (rules.required && !value) {
        showError(input, rules.message || '此字段为必填项');
        return false;
    }
    
    // 如果不是必填且为空，则跳过其他验证
    if (!rules.required && !value) {
        clearStatus(input);
        return true;
    }
    
    // 最小长度验证
    if (rules.minLength && value.length < rules.minLength) {
        showError(input, rules.message);
        return false;
    }
    
    // 最大长度验证
    if (rules.maxLength && value.length > rules.maxLength) {
        showError(input, rules.message);
        return false;
    }
    
    // 正则表达式验证
    if (rules.pattern && !rules.pattern.test(value)) {
        showError(input, rules.message);
        return false;
    }
    
    // 匹配验证（如确认密码）
    if (rules.match) {
        const matchInput = document.querySelector(`[name="${rules.match}"]`);
        if (matchInput && value !== matchInput.value) {
            showError(input, rules.message);
            return false;
        }
    }
    
    showSuccess(input);
    return true;
}

// 验证单选框组
function validateRadioGroup(name) {
    const radios = document.querySelectorAll(`input[name="${name}"]`);
    const checked = Array.from(radios).some(radio => radio.checked);
    
    if (!checked && validationRules[name] && validationRules[name].required) {
        const formGroup = radios[0].closest('.form-group');
        formGroup.classList.add('error');
        const errorDiv = formGroup.querySelector('.error-message');
        if (errorDiv) {
            errorDiv.textContent = validationRules[name].message;
        }
        return false;
    }
    
    return true;
}

// 验证整个表单
function validateForm(form) {
    let isValid = true;
    
    // 验证文本输入框
    const inputs = form.querySelectorAll('input[type="text"], input[type="password"], input[type="email"], select');
    inputs.forEach(input => {
        if (!validateField(input)) {
            isValid = false;
        }
    });
    
    // 验证单选框
    if (!validateRadioGroup('gender')) {
        isValid = false;
    }
    
    return isValid;
}

// 密码强度检查
function checkPasswordStrength(password) {
    let strength = 0;
    
    if (password.length >= 8) strength++;
    if (password.length >= 12) strength++;
    if (/[a-z]/.test(password)) strength++;
    if (/[A-Z]/.test(password)) strength++;
    if (/[0-9]/.test(password)) strength++;
    if (/[^a-zA-Z0-9]/.test(password)) strength++;
    
    return strength;
}

// 显示密码强度
function showPasswordStrength(input) {
    const password = input.value;
    const strength = checkPasswordStrength(password);
    
    let strengthText = '';
    let strengthColor = '';
    
    if (password.length === 0) {
        return;
    } else if (strength <= 2) {
        strengthText = '弱';
        strengthColor = '#e74c3c';
    } else if (strength <= 4) {
        strengthText = '中';
        strengthColor = '#f39c12';
    } else {
        strengthText = '强';
        strengthColor = '#27ae60';
    }
    
    const formGroup = input.parentElement;
    let strengthDiv = formGroup.querySelector('.password-strength');
    
    if (!strengthDiv) {
        strengthDiv = document.createElement('div');
        strengthDiv.className = 'password-strength';
        strengthDiv.style.fontSize = '12px';
        strengthDiv.style.marginTop = '5px';
        formGroup.appendChild(strengthDiv);
    }
    
    strengthDiv.textContent = `密码强度: ${strengthText}`;
    strengthDiv.style.color = strengthColor;
}

// 初始化表单验证
function initFormValidation() {
    const form = document.getElementById('registerForm');
    
    if (!form) return;
    
    // 实时验证
    const inputs = form.querySelectorAll('input[type="text"], input[type="password"], input[type="email"], select');
    inputs.forEach(input => {
        input.addEventListener('blur', function() {
            validateField(this);
        });
        
        input.addEventListener('input', function() {
            if (this.parentElement.classList.contains('error')) {
                validateField(this);
            }
        });
    });
    
    // 密码强度检查
    const passwordInput = form.querySelector('[name="password"]');
    if (passwordInput) {
        passwordInput.addEventListener('input', function() {
            showPasswordStrength(this);
        });
    }
    
    // 确认密码实时验证
    const confirmPasswordInput = form.querySelector('[name="confirmPassword"]');
    if (confirmPasswordInput && passwordInput) {
        passwordInput.addEventListener('input', function() {
            if (confirmPasswordInput.value) {
                validateField(confirmPasswordInput);
            }
        });
    }
    
    // 表单提交验证
    form.addEventListener('submit', function(e) {
        if (!validateForm(this)) {
            e.preventDefault();
            
            // 滚动到第一个错误字段
            const firstError = this.querySelector('.form-group.error');
            if (firstError) {
                firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                const input = firstError.querySelector('input, select');
                if (input) input.focus();
            }
            
            return false;
        }
        
        return true;
    });
}

// 页面加载完成后初始化
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initFormValidation);
} else {
    initFormValidation();
}
