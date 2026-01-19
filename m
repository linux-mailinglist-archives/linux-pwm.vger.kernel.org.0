Return-Path: <linux-pwm+bounces-7936-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE2AD3AE9D
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 16:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E77B30056C5
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jan 2026 15:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE0331C57B;
	Mon, 19 Jan 2026 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ki1DWXlX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F196D37B40A
	for <linux-pwm@vger.kernel.org>; Mon, 19 Jan 2026 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768835624; cv=none; b=nNFON50OL8ZfCvx++JTlE1ghl56MkhGcy4xcjMtj7PKaP/pQRyILE+HIMiRGqqa/Tczfkk1LIRilqlIPWj7SFLFjUWJMeNh+TYbBjhgkPBLk97end06wCYhku1jRvyC0ZEppzoKCgxwt+IqsU6TzTFuQfU4Lgev3g1DUU2VLceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768835624; c=relaxed/simple;
	bh=GmYUmTPZv8Ho5hQ3K8HKaFkdBbFGHj2uiTTokMDs3U4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n0yd6Riq5GZGEFj0dnQg7OlQnvERsGVt93RMzuAvixP6OkS2LECPsRqtc5cBRuKpzHNVid+ZrAwHtTqmNkeftXWhovyqsfBYKdZraJ2Ma77pbRvDOuOcSm2eJ/m7sTz73LSNxive6lU9z4i3EuRneXBjalCceUNPsD1E1JCGtKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ki1DWXlX; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-432d2670932so3523901f8f.2
        for <linux-pwm@vger.kernel.org>; Mon, 19 Jan 2026 07:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768835620; x=1769440420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KyhbOiDkqFpabmsI0akIUYELn5kUKeSt7Mv2K/bOKIQ=;
        b=Ki1DWXlXb7KLPa+S4Il4CAxXZ82OGopWD24yuoT7R5cFAzE0h/Zin8vJQsribgkgu/
         RIQ9Kes/t/x4szlGnOPWC6FxzF92vFdOq1iEUjvLN5M6OusZ5GIdvM29ueuhDUEaHXHw
         3qeRZlXycCJRc4GUVE5IVw48/WqE3f7hIRZ3iYPov00z9m+tnQ3gRrT9cMEMjCU2X1yN
         PIUsnwKiRES4aLRgGSpZ2rIc5+j1249d6FUO7wbmsA9AKzeS19shkklU/OszqyfzLTqJ
         2+xiEIaM3iv0WGGBtKQgylg8Bsua8/UH94fSJ04e5ZG8ZI3WHHXWcSdAojH3VwrlXqkj
         zB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768835620; x=1769440420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KyhbOiDkqFpabmsI0akIUYELn5kUKeSt7Mv2K/bOKIQ=;
        b=o0Ov0jdXFbH9l8Xyp/ysPGegNGgxC9E1CNygcf/W72KmbCj7o18mxFasymxMv8XHjc
         KVme+K/XwbVib6ThBPShz3S5bRssqYsuNY6UiLVftVXmrhzz3k93XEonSKjIfURAGmd1
         p2BLoRu/5tL3VsHNLCd5XfE/OsF4+XQN3rk6PBbXWUZhzVYRk9+znPDNm5c6hKXGxE9D
         UIoJclGKWqabUhyoNFZnk+CZQ2BpwwzHWWNdMfcA+uEH21mb4pMM6S3cmvzqFiRhPnLj
         PHbjlbfzEjbU23qH7/k06BiNnuyBOYS2C9ThyDa0T4ngfmWHNxWGivyfZVmhJy4YQsFM
         KQ/Q==
X-Gm-Message-State: AOJu0YwEmfsw8gFATH/wRh+ljlDiyw1nmwD90guldPtNgTAGXCzPFZWd
	/74SJEj2SQMofjKjx6FVajGDVIT2jgxRd0v8vfxfVFCGu4zn9cfsTX5MFwB+sx1N8Tk+epNiF6b
	rNSCX
X-Gm-Gg: AZuq6aLiDyS7xwLYJZX9txEf60yTudBmIxYX2WXIbiLuHD/vZC8ucSW7qWve0IjnKrx
	ltbhOfLb0YcP8BhV3e3HnHD302KhFeL4IsDpkAlmYwM8EEs4upaoG9vW+jwtC4RKGKhPkhCZKdT
	ABbJb1cGifVg/Th01baCmFElyQ7ojY59T2y+m/kKfupI8440/B1urtuMsqlJG1mBlNTHa6MoOQA
	YSAMV7rme5pGYhY42jOH2hBzHV04yK90+aUej06gAqj+beiBDK2R2w0iTQ/AbcLA6ylShR7sLPF
	EPeqeOBS6jpv+paAAMKIihR14wrfwa55fLTFe/Zqo+OFttOh8eUvJwe++potx9dxWL5KB+Qh+7H
	HMcMNpQsHYt8qkr4HKLEuyupYRGcebu3wZmYMN/SJC+gSYPI7+xNiQkF9vq1wiive+2Kykruena
	HNbzQSptGs1E458JEf1xd+lFXAGjUOFR+r3O0/XzcvbzunS+gvO93hzLFs5A9oCmu/gVoneQKD
X-Received: by 2002:a5d:588a:0:b0:431:62:d946 with SMTP id ffacd0b85a97d-43569999473mr14983047f8f.23.1768835615328;
        Mon, 19 Jan 2026 07:13:35 -0800 (PST)
Received: from localhost (p200300f65f20eb040fd825a50706214d.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:fd8:25a5:706:214d])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-435699272a0sm23919949f8f.17.2026.01.19.07.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 07:13:34 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: Ensure ioctl return a negative errno on error
Date: Mon, 19 Jan 2026 16:13:26 +0100
Message-ID: <20260119151325.571857-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1959; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=GmYUmTPZv8Ho5hQ3K8HKaFkdBbFGHj2uiTTokMDs3U4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpbkoVRvSHxyEJ86Irn71qbsXTXcz9vUjduAEP7 oLG/Z1X1buJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaW5KFQAKCRCPgPtYfRL+ TpiqCACrVIW3GYsqelCF0fD9WRN2/yO5HUaSbFavXUXmMN2cPgf/7Ip93FECJc24MDpau3nyyiJ 4iFoReXhNaWJhTNmGoXlCP9O1yvUon3e96pZ4WnR4PUCE8d9leuvU0okTwg+Kozc/uc5XAFIsTT ovZl0hcwKQiH4DjB4kJFdJVOBvtH8Cg113eezC72/0dUGspt9yoZGIeKEZKo+n7CMKtZiPDWsof LwUveVnTeBf9QO9alkvmmRMW7dIv1dluaXx89yA61TgW5+U1j1X862Dezwb9m1tQMzDY4u8/a1g 0zATskfF1dr+DfV7P8SyfEfClTSP3b2r84T1o2pZXXCDG1et
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

copy_to_user() returns the number of bytes not copied, thus if there is
a problem a positive number. However the ioctl callback is supposed to
return a negative error code on error.

This error is a unfortunate as strictly speaking it became API with the
introduction of pwm character devices. However I never saw the issue in
real live -- I found this by code inspection -- and it only affects an
error case where readonly memory is passed to the ioctls or the address
mapping changes while the ioctl is active. Also there are already error
cases returning negative values, so the calling code must be prepared to
see such values already.

Fixes: 9c06f26ba5f5 ("pwm: Add support for pwmchip devices for faster and easier userspace access")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 515fdd16f733..41fd3a9b2883 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -2295,8 +2295,9 @@ static long pwm_cdev_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 				.duty_offset_ns = wf.duty_offset_ns,
 			};
 
-			return copy_to_user((struct pwmchip_waveform __user *)arg,
-					    &cwf, sizeof(cwf));
+			ret = copy_to_user((struct pwmchip_waveform __user *)arg,
+					   &cwf, sizeof(cwf));
+			return ret ? -EFAULT : 0;
 		}
 
 	case PWM_IOCTL_GETWF:
@@ -2329,8 +2330,9 @@ static long pwm_cdev_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 				.duty_offset_ns = wf.duty_offset_ns,
 			};
 
-			return copy_to_user((struct pwmchip_waveform __user *)arg,
-					    &cwf, sizeof(cwf));
+			ret = copy_to_user((struct pwmchip_waveform __user *)arg,
+					   &cwf, sizeof(cwf));
+			return ret ? -EFAULT : 0;
 		}
 
 	case PWM_IOCTL_SETROUNDEDWF:

base-commit: 3bbf529821f64cebad9f385af19e149a9dfffead
-- 
2.47.3


