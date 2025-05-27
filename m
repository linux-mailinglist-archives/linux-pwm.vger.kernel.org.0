Return-Path: <linux-pwm+bounces-6152-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9034AC55F4
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 19:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414E04A4C83
	for <lists+linux-pwm@lfdr.de>; Tue, 27 May 2025 17:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA4427FD56;
	Tue, 27 May 2025 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PQ6LvW6j"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD5113790B
	for <linux-pwm@vger.kernel.org>; Tue, 27 May 2025 17:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748366124; cv=none; b=uonUM/OWqfVksxG4KM5DuB/iriWmw2oyqQX3ygOtHAmulFBAesnNxwEdHAi3RsL8GPZ+ze0daKAbRi3iNPSu6mIh89Ia5n5e+Ge2/Nv5H7KaOOHl6yamaN0aTYvczuz1BhXY9dgIFvoYLNdr3OBxy6EUHxpz8NgMHEDcb+wwJTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748366124; c=relaxed/simple;
	bh=lo7q0vAjnRMqOT4+3JKAMcw3uToSM7aewQO5nGtZTVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OZ3bLBSn534pJ2plBOW8nFaZpEOAjCUw2kXhgpOw2o/q7+mxTALSJjY5VU3No43Yl/nYIaAf2FU5CkbUT3swvMTX7UXuV5zzos1A+CSg9Szf2CwgZ1939/WDqT0Pdr2ZmZQkQAQ8rurbwTzNeEtHtu94TuRhkz2gasZA22kPbHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PQ6LvW6j; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a36efcadb8so3523926f8f.0
        for <linux-pwm@vger.kernel.org>; Tue, 27 May 2025 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748366119; x=1748970919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MF27c9rRKSYoup9DCYicRvlKjG8K16l+EHL6jMeQHzM=;
        b=PQ6LvW6jFZcrnZiNV0/7Tx6rj0hUEG3gYcz4PUbKyVfgOqQI3zFCKfn4sdNy8Rhz6R
         X4WQT4D3hLeEq8b+lwJgqph4cw2H4PPVZT2W60K6w3f7oCVZF72BsCq99biiphG74wIX
         KnYWGb79EhPa3nSThDK1Gvl64IncI0/v4u7ZGEjm88AOc0rk9b6m1RUU5E6RcAf6B1gl
         ZPB4eWW0n4V4pWtAYoOTN1cCXM2ZvUhU7dLYJL7hvysk5SkM+OHTsJ9FVaaY6K5Zx5Kd
         c5muqO070k3hdjUCjV0HsyQ0Ot4r8y1djM0Vd1MB99XXda15fjLyvNzIeSfDQsr4Pceu
         Qkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748366119; x=1748970919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MF27c9rRKSYoup9DCYicRvlKjG8K16l+EHL6jMeQHzM=;
        b=ZC7WrlLzIid0VlJidR9NFwrOk+BiKI4cETdOrhbkhSfMp9o5ib60tlro1JAaK1AmFz
         hyINcPsgv52HizRF9BMLkFvknJ+K+9ytsjtUx4ZTt+ezmUZjJSaNdhN2LcD6DNbeOIMT
         9jLiz3WmNCQSCiNBZvMRoqF6k7R2v2mRhS/N30/AOsxPSFvyNZ1GVSjE6vtja1BX39l6
         3U4nMnCmiDNBhsYxqtS5NAZZdXtWaQRnYUOwqnu5dNh1k/8TJI6XVOmli7Bq+9h9uE1h
         nYHUyarOHvVaTwVu/hcaTQ0OP/xXXKKdrovgd6Vkr0DsUxumjmegQcZOzwVHKIS10YaT
         jfPA==
X-Forwarded-Encrypted: i=1; AJvYcCWVgpY8ehVNMNahA7Gyx7D7gg4xlwD5hW8hroGy/+maLjLrU21ZMhKJBd0WqJYaZA9IEJtDjc5EIXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWs+UoT6o16wLr6lkUbSz1Knw2NfORiDCq0NW+Xj+N4P8QTlkO
	a7nJB5NlellvN0uEJ6AoZNO4VGyx/0Hhk39QqRnrn6Qt9m3HlyVTtUePXCqiihyy3DU=
X-Gm-Gg: ASbGncsa2Ha15/snsEDRwmFaJMdG8Ay8VWrJ1Gf1MF1dNP31nIRRReLCwQ6ehZXphxO
	jAfD2SQ0QVsTxCIocArM7y0Fmu9CJVJyPnCzuWxRDBHn/mupMd3ev2ZUIKeX6EU1AtrpMZbioC6
	8vj0gWgFyLyrIz+AT59hUctGJm/DD0+ZYNwpo23ApKI157pJ9CfqDOm/DjRfy1HLUIxjkXNK2wK
	KJj42JXhSHyZ3NRRGhRN+5S4Nl6H5uikrCgIMR0z6jwtw0pMbMmH2IjFCW8FFZJ6PrGb1kdBPIf
	mpYluNFfnfZjtSIkwASqZCo7Q1TBqIaQHC4i8trvjTCNuhC6rg3xYBzXllQ6JQRGuNED/LxmGCG
	/UVrTiRvJOrwgmy1GEg==
X-Google-Smtp-Source: AGHT+IFpTB7TNLh6pQDK/oXXCIK8emry0Gzw8WKuisddY7ds5DeVmLH7BHeY5kquTGkx95P40nkhsQ==
X-Received: by 2002:a05:6000:2586:b0:3a4:c6bc:df46 with SMTP id ffacd0b85a97d-3a4cb498f7cmr11355655f8f.49.1748366119417;
        Tue, 27 May 2025 10:15:19 -0700 (PDT)
Received: from localhost (p200300f65f13c80400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f13:c804::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a4e1fe9430sm2417186f8f.75.2025.05.27.10.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 10:15:18 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Anderson <sean.anderson@seco.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: timer: xlnx,xps-timer: Make PWM in example usable
Date: Tue, 27 May 2025 19:15:02 +0200
Message-ID: <20250527171504.346696-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1097; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=lo7q0vAjnRMqOT4+3JKAMcw3uToSM7aewQO5nGtZTVk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoNfMZAti7WzkSVbkgZKbDhL7HlMQghcuZss1Rk gySeAVOl3iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaDXzGQAKCRCPgPtYfRL+ To7jB/9HOOPDuH+KcIJZ2UNKgt5nOFBdUE882ug7qeqFaYQHAAd7DWA/qoCuwxJSxu4Qs/bIoqg T/ujO/oyxurwcn/5j3bQSRkoUFPWcX+Bar7XfBaqpiiEltEuA2VZ4oxVr1VY0E1dtUwuJKHydZ3 bbTM7J2+tpB6fEB5yGrwy2LQAA2yKtTEo0wB27sMkWyYdhS1rI0Ib9qbWsZs+HDvbRSgloQbTL9 DobcZmP8ESede9SXcZpt1cqT/e4Hj4He5ryBrIfBX1oCVMGbIpL/hwuCo2oe528VL+VKtQ5n5vt ShYPRPSz94vrctseCcl2vQSxB6AjkN72G/kUKrCcV3hOpbwa
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

With #pwm-cells = <0> no usable reference to that PWM can be created.
Even though a xlnx,xps-timer device only provides a single PWM line, Linux
would fail to determine the right (pwmchip, pwmnumber) combination.

Fix the example to use the recommended value 3 for #pwm-cells.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml b/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
index b1597db04263..d36cbf0efbd6 100644
--- a/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
@@ -82,7 +82,7 @@ examples:
     };
 
     timer@800f0000 {
-        #pwm-cells = <0>;
+        #pwm-cells = <3>;
         clock-names = "s_axi_aclk";
         clocks = <&zynqmp_clk 71>;
         compatible = "xlnx,xps-timer-1.00.a";

base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
-- 
2.47.2


