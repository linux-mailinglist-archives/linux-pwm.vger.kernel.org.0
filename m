Return-Path: <linux-pwm+bounces-5373-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72E5A7F64E
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 09:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687D67A4891
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 07:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B032638A9;
	Tue,  8 Apr 2025 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WHuEO0vi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA84263F47
	for <linux-pwm@vger.kernel.org>; Tue,  8 Apr 2025 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097516; cv=none; b=cVktaK+ZeipwGGG3nMW+/5Ca1CcQAyxx+IH8bbuRRXuhjzIzmeJUU/tnRRyi6kSFTmI3lp3mEb68ix3hruxmQNld+OyNR2u5EgKPG9msnEDKpPHWQB9hE+ZGB1zTulIRv+GEBz54nf3gw9oPsJ74+pabiXN6d959VonUlr4nEDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097516; c=relaxed/simple;
	bh=FUbTRighwa5eieYU38YRchMwR46Y0TXpyhzds2/dP/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Yql4QO9bOLTN3t3yDHdoSON+igJJsvnxQcqoA4Etl8FWhyw4XGIMKqoz3YU8KQyZ1XX2ciqG7qB/kZ3OfLgweoClRzoATez8tGvAy0Adgr+JiXQbfgmnLtxt0uFW5qGZay7wT0UAZZy9jmst7iU+sXo//QdDq56K6DpWnx5vahM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WHuEO0vi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf257158fso36288305e9.2
        for <linux-pwm@vger.kernel.org>; Tue, 08 Apr 2025 00:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1744097513; x=1744702313; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6BtbHqsMhUos67G6Oxw8ZXZLpL8UlKP9+lIMwAqXx4A=;
        b=WHuEO0vi43eHm/RWEOpLb35RowTgAKYK3Tp96gi+aLgsPb4fbfwqwyTZHk5oucC5yf
         jdNWsShbw4eX75qhK6pK6vG6Sc7J9/Dmsg2Law+jFt0tZGpLACmKWzXcLdQD4x745q9Y
         gefZOiJE196ljyJQoyk8fJUl+NDkQFApYHl7rpVwjZHcfw9+KJehe3YYW1xFk1PM8n0z
         1LQM3gHDZX0E4Rjo06D7pLQ5mLTwhUrBMQXfI5MQR/WIYtt9SIEkjRBUoBxjE5+tzQjR
         Oj5b3eJEG7tu/+VF79zN4Qhm7C3UauwJxNqoN4WIi7EFtCpAwKx95EqcH2gg3TmO859A
         zUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744097513; x=1744702313;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BtbHqsMhUos67G6Oxw8ZXZLpL8UlKP9+lIMwAqXx4A=;
        b=VUKib60U+eM41lj4j9ipB+co48nNRHnKJJzjO1+ijZGwm6sYeLr5vHHuq6oGjd5mhp
         xYwlheVoAUt+DgcZtt1xZnj+wMZKvqzLWsaRws5plHWLmkMNEa1XPPPYVVa1bN2UON9S
         SYGj7UDDFlEXGxnL1Mrk1h4884dImkAP/F9r9DgfRJmrOd8PPXgnA8gcNq8uf44F1BBV
         lHCeOYFwrg+qtGnpIqZQgV1sXKXwoqjOfuRLZky1RpkfFaTw6tQajFVB5tTIkfBYonTj
         8CyR1Fb/a9Pm+ssT43IfUIKjsSTDQ3TaHVolkPmgNQeBImkwoPZZWZpmHkegVdG3KwJa
         UrIw==
X-Gm-Message-State: AOJu0YwLKG11geqif/QtriJPlWOvYwSUwk9XmaEn9KvH1fyIBCkV/J08
	j3E1kvDEsAMMvui7sw1ZyL0qdZT/H3LbKEuDVvZvxLakL0gXg3ANtfmI/J7q0PM=
X-Gm-Gg: ASbGncs+pANWSvHSFmqmDyffR5B707dJB0Oam+TVY+POEkiasFA3x2Hpkoy5QsMnCbQ
	z/QJXurUtdXQHMiVdGojAMwp5reVheBijtdIUA1kePm7L74aOnbMd/prOz3/aVBaE596J3dlMnm
	cmAwG5XqBK5EEC4Ezyk6f1KHZvADJdTh/Ely+ptW6r9vl0smhzXicGZtPN3rfp024x+n9m/R2kL
	HQYMEuX3SbhQk4LqqJFdRQjXqZoMUCdpRspK/uJDIyccY0LILuS0QhvB6RTbQBhZ/3rtSnxV2N8
	X/jkebZ88bZ7eVwlGNhdFkX92jY6zYvBo9y4jw==
X-Google-Smtp-Source: AGHT+IE+Xxom6NOhosQq0m8djhtf9SwUOVEwposQh1srQRR6dan0KmkkmgYrxGpxn0xF2WRjmrUqSw==
X-Received: by 2002:a05:600c:b8c:b0:43d:4e9:27ff with SMTP id 5b1f17b1804b1-43f09261197mr36027095e9.7.1744097512693;
        Tue, 08 Apr 2025 00:31:52 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:2adf:eaae:f6ea:1a73])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226be7sm13846370f8f.89.2025.04.08.00.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 00:31:51 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 08 Apr 2025 09:31:46 +0200
Subject: [PATCH] pwm: pca9685: use new GPIO line value setter callbacks
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-gpiochip-set-rv-pwm-v1-1-61e5c3358a74@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOHQ9GcC/x3MQQ5AMBBA0avIrE1SRaWuIha005oFmlaQiLtrL
 N/i/wcSRaYEffFApJMT71tGVRZglmnzhGyzQQrZiloq9IF3s3DARAfGE8O1ItWzbrTtpFYOchk
 iOb7/6zC+7wei4oJAZQAAAA==
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1992;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=1U8Gmj+3lvIlR8YGdhnk51HbgumUU7NfSqTqb+zvZ/o=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBn9NDjW+d7FBwyeFzKIyJR2a6Z8Gc6Y60t0jDGZ
 /WgrTFfIxuJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ/TQ4wAKCRARpy6gFHHX
 ckkPD/9y497qWEAtRXgBzMVqqT3uDVMKf3CMYude1aFE44ClsHYEYEWcRLXgzvOOOM4KyzStQFy
 HanKEHM+uSdXPs82ipC0Kiz+f4HXP1KuMdpNNIvYufMU2RzE7U2w/wCAQ+b/x4QCFfHo0rvYroI
 XwrbdJAmIx2+DmAvS0JRrejn4yaOAE2zUsW47/tNotpwAJhhh/vJ5md4D+AbAaJ0fPiQLMqmFVq
 rtDJf5sE4/BffloxGLmOpMHNqfv97a89Cy6cy1TMlEfo67QAK2Qx/cqmD/LwFSGXgBSLvPh9T+T
 KN1ZnVup0UTT46XsOAdaGvbqA8pg4ddFedXOmLNt2q1UmspB8G2rt4IQ3cyuUugiOGWkAHYYWgc
 4zvfeso1bKKV2HpXd1NIgf0wMyir7k26qXJuKicJiKWY88hSP7uFLeBSvuTA+nrmraemlDVgGzx
 X/1Izx0qBxGZT5HzW9zKz0SpwXic2BQQ5nvaICnOG2Gpzd7Rcw4e2fJIrvFqXuCkz70GZ1G5LRS
 8zes4tYb2/Jx7HwbBRq0DW4nA1IYd7ywvXx0rUgl9ZOkSPjSqyNnKP6/g5TPDFjPE22MOpNGlrL
 9C15eNYBk8V8e0ToggORnHjL3a1tXnMlYir//YSSuvdcPBBec5iYZfWvlRvmtdIoTNCs77b73Zk
 JCb6zElp8Q2puhQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Commit 98ce1eb1fd87e ("gpiolib: introduce gpio_chip setters that return
values") added new line setter callbacks to struct gpio_chip. They allow
to indicate failures to callers. We're in the process of converting all
GPIO controllers to using them before removing the old ones.
---
 drivers/pwm/pwm-pca9685.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 5162f3991644..eb03ccd5b688 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -263,12 +263,14 @@ static int pca9685_pwm_gpio_get(struct gpio_chip *gpio, unsigned int offset)
 	return pca9685_pwm_get_duty(chip, offset) != 0;
 }
 
-static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
-				 int value)
+static int pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
+				int value)
 {
 	struct pwm_chip *chip = gpiochip_get_data(gpio);
 
 	pca9685_pwm_set_duty(chip, offset, value ? PCA9685_COUNTER_RANGE : 0);
+
+	return 0;
 }
 
 static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
@@ -321,7 +323,7 @@ static int pca9685_pwm_gpio_probe(struct pwm_chip *chip)
 	pca->gpio.direction_input = pca9685_pwm_gpio_direction_input;
 	pca->gpio.direction_output = pca9685_pwm_gpio_direction_output;
 	pca->gpio.get = pca9685_pwm_gpio_get;
-	pca->gpio.set = pca9685_pwm_gpio_set;
+	pca->gpio.set_rv = pca9685_pwm_gpio_set;
 	pca->gpio.base = -1;
 	pca->gpio.ngpio = PCA9685_MAXCHAN;
 	pca->gpio.can_sleep = true;

---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250326-gpiochip-set-rv-pwm-e3b949d7296f

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


