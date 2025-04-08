Return-Path: <linux-pwm+bounces-5386-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBBBA80DE7
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 16:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693933BB2FA
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 14:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A821DE4C5;
	Tue,  8 Apr 2025 14:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BjGvoPzZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CCE1C5485
	for <linux-pwm@vger.kernel.org>; Tue,  8 Apr 2025 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122261; cv=none; b=XNHoKy9y7unnEX7kG8YOXGmha4OMowDJcV17MDxSbYaS1GCQMPhzFIcCHGDj/DbuESgMs9xK4K2vE6z5SvLAm6PvSkxaS3HCEelgyyTAD1AAxWseAGns2Sp3mlI45dFzwDADDXdCNdDA2met7BMPB0fOpbAQEociqNYttpc+sco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122261; c=relaxed/simple;
	bh=J292iOE9WkhH72JvBdw12fX0X0zF4DUVgfCar1FYmPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpMs8cwiOOcAGUw5U7PA3jD6QqIyEz5L2+9PiaGlR9G95v17SwxJ7QgHyVhQzIpjj/1HPcUqA+aVQC84noN5toArd3p1Ld0Zig2XAQ9XM1YtTAqqSDy6I9dqbqFOxJOSaHVwlOl1BDDeB8hT9y4aPMrXUiGjAazuHaFjDd6vSQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BjGvoPzZ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso11123162a12.3
        for <linux-pwm@vger.kernel.org>; Tue, 08 Apr 2025 07:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744122258; x=1744727058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jN75VHlpEpvNXbp74E5FvhHDPRMXANPA97q82FFTYMY=;
        b=BjGvoPzZ/RpuXPj1t66Ig2oC8P27wbSI+sCF3W7Ql90viKunEMSxpiSwI26prj1X1k
         h+qH+1CWdAjqKI2AoiJGaeOCGqbHfBnJwOUVsmyGB64bmNzxSovZ2WmtBJzeGwYowxFf
         GOYjWw2jcvbR1K6naIHC/y8oDIHXVGzi+QL5jV0XceVQTQqY3W//TA7xefrg4TCdtaS2
         5s+oZa2qZMAAV/8gweadqAX1G14SZ8QZbHdQNNXM2sXPem3ol/yWxQXlBLWC0EDCtoP9
         3mLCxhuSNkFVgULigG6hje3n3AgGU/d2R8xjjn7Syxz6+uiMbTszVQE7kNDihXJ8wL7D
         scuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122258; x=1744727058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jN75VHlpEpvNXbp74E5FvhHDPRMXANPA97q82FFTYMY=;
        b=BhwujmjtuLOXV9aQ7ovgUZJbu5D0tAHQEh1Sps3GJdZ2NnpLi9DCHwf/624CpAtzL4
         ZueuT8+Q5hLAM599SnuT4IZtm6RVlNhYfCYh30v/MFJ5fq4919a7Ie1+Vc2v3u/zOZlg
         fQPuVeauFzHyVXGnSxIvY8C/Xq6E+GwhPf8xJWM5YHL7HYZCUZgJ2ppm6fYmb9ZKaS5G
         rw+rmX/qAGV3YAKQOhWii038jM3DmuWsBYYONvhDtVYKBkOEpW9DGsXtWVq46OHvgVt2
         cDKvuiIeurozgMz+f8O+gZtYC+Ed0y+jyPC8YJnT+FNHPt0/e4UTGyJJYpE9hIqqtXsT
         Nvbg==
X-Gm-Message-State: AOJu0YyksFeaZbujhiREW3Ra0yWB5BN5Djqd/VrFebrZ6fkTtvJEAMzK
	8tzq9WIXD2QXiZC01QfZhVmag5n0EjF+h/vbxP4u7LsB2K3DDV9i/SshBmALPEv0zf/62UR0X67
	3
X-Gm-Gg: ASbGnctBx6Npout7kFh3Kf65qqWMkKkncqPs6b8EJDVg2SL2ddktIpu2fmcXUzL8m3a
	dgxWiVd2wC64qJshKYGVRs+/SGKk4IqKnXl+N96FveItN4lDYEhYlmRKwXK1u9CA7bolmwCg5j7
	20+VBWR2RMxJtjd5JTyKG8R5qVQcgmNulP3BsVQ2jSjrbZ/N+ZIa5T+BNS5h3DarowmrfGEXo5V
	SJDR8v/vyaYeTpqrz1ENnjU2sIk7QX+qpYDPHFd/vK0A8lauyiqJgwP2PhONbRfjFrwuoExYdKi
	xyBBBqjB3mOLWD3tFOdkHGlX0cVNaxeGSoM3vO6ZqDBN8w9eBg==
X-Google-Smtp-Source: AGHT+IF+ly+l4/UXy+tMS97/2RnWdvVrZV7ItHBInP0obZi8zGo0SzX72WCRJMp4qCaKmCr2ncFgqg==
X-Received: by 2002:a05:6402:501f:b0:5eb:9673:183f with SMTP id 4fb4d7f45d1cf-5f0db8352a7mr12278976a12.20.1744122257886;
        Tue, 08 Apr 2025 07:24:17 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5f088087a90sm7982446a12.56.2025.04.08.07.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:24:17 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Kent Gibson <warthog618@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] pwm: Better document return value of pwm_round_waveform_might_sleep()
Date: Tue,  8 Apr 2025 16:23:54 +0200
Message-ID:  <db84abf1e82e4498fc0e7c318d2673771d0039fe.1744120697.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1744120697.git.ukleinek@kernel.org>
References: <cover.1744120697.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=J292iOE9WkhH72JvBdw12fX0X0zF4DUVgfCar1FYmPE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBn9TF9/LpNaM/Bch8Has2e48caAj51HtjvT8X4R SrTHCuP2cCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ/UxfQAKCRCPgPtYfRL+ TomDCACo10bxApC4Nukoph5HIdTyAH85ItZMlMc72CtfYum40b1yruJffVXsKCVZP2X241L7cnu 8sQ9EPaKExwJisqiiF0DJXOhQGnru5jKnao+Gw/woTt5CWhqDHNOH3nONAtGdbBN2MMjmhq+6zd qQQWmJdNJF0ooyF/POQC5WPdCopOFrTCUCl5U9VxBbCwy/dBYeB2BF7Jx+valyH86tDt1m3c96I 06UaSkxGL7ksQQNR7VNPuQL5IUa48L6ttJabZcy4RHVICDs4JBTZOEzOHWxwbCdSvn9XPFn8IjE C7L7UZMYRQr1JdlcMJpE9eLJKHFx6Xy1JIXfiRfDZz/jVgPY
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Better explain how pwm_round_waveform_might_sleep() (and so the
respective lowlevel driver callback) is supposed to round and the
meaning of the return value.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 59cc8792e312..cec325bdffa5 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -229,8 +229,12 @@ static int __pwm_write_waveform(struct pwm_chip *chip, struct pwm_device *pwm, c
  * these two calls and the waveform determined by
  * pwm_round_waveform_might_sleep() cannot be implemented any more.
  *
- * Returns 0 on success, 1 if there is no valid hardware configuration matching
- * the input waveform under the PWM rounding rules or a negative errno.
+ * Usually all values passed in *wf are rounded down to the nearest possible
+ * value (in the order period_length_ns, duty_length_ns and then
+ * duty_offset_ns). Only if this isn't possible, a value might grow.
+ *
+ * Returns 0 on success, 1 if at least one value had to be rounded up or a
+ * negative errno.
  */
 int pwm_round_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf)
 {
-- 
2.47.2


