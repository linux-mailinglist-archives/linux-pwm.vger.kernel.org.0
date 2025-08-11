Return-Path: <linux-pwm+bounces-6999-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C117AB211C8
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 18:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A51505244
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 16:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0831029BD87;
	Mon, 11 Aug 2025 16:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="L/ZUnma7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414126F06B
	for <linux-pwm@vger.kernel.org>; Mon, 11 Aug 2025 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928093; cv=none; b=ZfNhLTJeKNbzF8YVhqCdoP/DMANrXpaTj+vihQ0/+7rpIv+8Ovvdm+mfuWipSwutYlMe/DgIBZrg+mDPoiVTVgD+TnR+sFKdfB8oZliv50exX+rn8Tzp720lrgCKW45/ejgsc4Hg4kr8+KcRpVU/NgfyQFvmAGsuNGBuuu7jt74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928093; c=relaxed/simple;
	bh=F7/JBNWuEO8QLQegoUsw+/qMBeLBjmf7TO5XCPg5QoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uW6Y8lOI+4DHjikmbpeVrtX2APIXBMYSp4V5gZDWZ1fG3g9/NuKBVOIlkqEbXZeiCtHO4ivkc704YEsSY6/aOZ828M+LZT4iPKwqd6vObaXrCzAx1VMu8wjRBiIx9DXWEjHEZR3yF6f2y3pNVEtfeI5Sqk/JyOsN7Whuacbeh/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=L/ZUnma7; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b788feab29so2767130f8f.2
        for <linux-pwm@vger.kernel.org>; Mon, 11 Aug 2025 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754928089; x=1755532889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqHOuWtiBoXXtPLCXTtFdifRYnkLSiUB2KOSNzZeHa4=;
        b=L/ZUnma76PnXlqY2Ym+XP45PEVCVrp7eroTCqadkE7H9pCNSi40furZI0aPiXjtGI7
         TvKq/2y7JMZIdTgVtM4aXTk3jnW01ApNt7FLhJ3bWpiL+Cs70WPgz5uz+8m9cDrT295h
         apkbV2SFtigpn2ucU9TcP9D3kKMVxuszYezuS7AnL3qp3xID7q+P3RhTJSo5Deqne7Fv
         hQ60kQD/wy8NmXdJezdyIyezOEI+LYHHYM9OFT3fx/H+g92krTAfSpTa3jy3Xwic47PZ
         PCYKIhh8QmKbKNim+Z7Ohf2lO9blmy1QllQj6smsruI5sK2/e8pas8Crp+/7nGc3gL1x
         Uh+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754928089; x=1755532889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqHOuWtiBoXXtPLCXTtFdifRYnkLSiUB2KOSNzZeHa4=;
        b=JtUk3TslbGgdkTsuP+xsQQ1X+j4YUC++/CWzfylTwc6dTbtkyaDdLwxtbRytRihmb3
         aZ+amt0JqU5gwWemZ9gRYhnaAT94m58v2a6a8O4wPwU789JRVnYlLcmTWj7VCZtWCIOo
         LpzLQe3G3aHwhhJhqIVSGosXih+Kj6tG9AD3luoxba6LSryC9obzrluA30APfkFTWstO
         IVH7Xccal3saZyOqQgpmUr4ovAMXDOTLXLtOK+tNPgUh9ChQ2ll/O2NPzb6eK5sxhoop
         ZLha8XW/mp8DZhQd2XjSuc9/KImVi3RUqEIi0UxcyQGrKbZVKkgSaNoeRyrrlEms5PAH
         FlxA==
X-Gm-Message-State: AOJu0Yz9mynYkZPVkFBq4K8U6oPEELcNXmDRvrbU4kOdP0xKW7Zi1hfY
	AmPCDeGBPkWrwX+Dr0yTHGS1TMaK3mWnZrrjFWXzmEHE87F3E/67teeYewsaKofXKjcOuvQd0E+
	XH0Wn
X-Gm-Gg: ASbGncvDcOk650XBI9+4LKb1pX6AzpwFx98DQJMO7kdoHqxx3vjHQezVoVAUaQsXPNZ
	WOUMhPII4yc7hRWTl32feMBhy81y0lpiu4B7IzzSOrUBkRRk6dgCFehBLOJU2RBuu7dAAwU+uaR
	IjekmzpmuE9uBCrp7O8oL8OwK9/mL9Ir9xDyQLFUFuJd+oiClJ4+Iv35/YjHGLv7uduO5djAdNY
	WAGidsOB+NjXU9psztWX4n2ATPyWI2+Fuo9fuG7P8eCKHuJSsk3Qf7ReNdDZFOpjWWlfZjCbdqO
	zTQ4wdmS0dL4Cime1zl/Mjqmk0zxT6AFCmonzbT4vyQahIKUu8m5ur5DT8XKCg8pEyUTnLyVuFv
	8vI2BSLYIjOhJ9L7X9Vqh3/JD3u3cgwD7GyO+zpmPeJsIvlk3s2PY/INty47R3MINQB9mvmStrm
	w=
X-Google-Smtp-Source: AGHT+IFnmKG3/6D/9Ykn0+yysjq+mXHnKe0JV5AcYsw0NuYi/HsRK3r/isg1xjULn4co8T5T5FFt1Q==
X-Received: by 2002:a05:6000:250a:b0:3b7:99a8:bf6e with SMTP id ffacd0b85a97d-3b91101719amr216405f8f.51.1754928089249;
        Mon, 11 Aug 2025 09:01:29 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b8f8b1bc81sm18909211f8f.69.2025.08.11.09.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:01:28 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: "Philip, Avinash" <avinashphilip@ti.com>,
	Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH 4/4] pwm: tiehrpwm: Fix corner case in clock divisor calculation
Date: Mon, 11 Aug 2025 18:01:02 +0200
Message-ID:  <85488616d7bfcd9c32717651d0be7e330e761b9c.1754927682.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754927682.git.u.kleine-koenig@baylibre.com>
References: <cover.1754927682.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1680; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=F7/JBNWuEO8QLQegoUsw+/qMBeLBjmf7TO5XCPg5QoI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBomhPGnsFMW7Mu5SEPpiu9bTxDOtmeYT344K8+l 5EHbjnlLu6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaJoTxgAKCRCPgPtYfRL+ TmzFB/4ifgufYrW3XXsQAW5VVRvF9wQNZemaBjxoVodDbEWOQQJYyl9hvfadczzJqBfGy0Bcx7b 5w7qxF9EZ8VBeW/e+sprCH6GqMBfiQ1SZlpUwFJ3S+TydRkonw8pynv8oDNEIJSHF6GJVbWlT7l oNCVjZkAwIEtc2wf3j+NXS0WAfOh6YIe1WfmnlOUeNHziU7o/K/imN6JRWoT2rMveyPPDMCxaOM Apx8oNiXCkHHphgmDAlY3Z7KF3Yx4TYRhS2/TPtpWB2ce+uHsyQqzqmG2jHwDOpN8etVQxMYVf0 kVsSOQIuHCI6xhtyK6fR+JDahL2/6ki/+6rax5FWb4cbh8/z
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The function set_prescale_div() is responsible for calculating the clock
divisor settings such that the input clock rate is divided down such that
the required period length is at most 0x10000 clock ticks. If period_cycles
is an integer multiple of 0x10000, the divisor period_cycles / 0x10000 is
good enough. So round up in the calculation of the required divisor and
compare it using >= instead of >.

Fixes: 19891b20e7c2 ("pwm: pwm-tiehrpwm: PWM driver support for EHRPWM")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index a23e48b8523d..7a86cb090f76 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -161,7 +161,7 @@ static int set_prescale_div(unsigned long rqst_prescaler, u16 *prescale_div,
 
 			*prescale_div = (1 << clkdiv) *
 					(hspclkdiv ? (hspclkdiv * 2) : 1);
-			if (*prescale_div > rqst_prescaler) {
+			if (*prescale_div >= rqst_prescaler) {
 				*tb_clk_div = (clkdiv << TBCTL_CLKDIV_SHIFT) |
 					(hspclkdiv << TBCTL_HSPCLKDIV_SHIFT);
 				return 0;
@@ -224,7 +224,7 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	pc->period_cycles[pwm->hwpwm] = period_cycles;
 
 	/* Configure clock prescaler to support Low frequency PWM wave */
-	if (set_prescale_div(period_cycles/PERIOD_MAX, &ps_divval,
+	if (set_prescale_div(DIV_ROUND_UP(period_cycles, PERIOD_MAX), &ps_divval,
 			     &tb_divval)) {
 		dev_err(pwmchip_parent(chip), "Unsupported values\n");
 		return -EINVAL;
-- 
2.50.1


