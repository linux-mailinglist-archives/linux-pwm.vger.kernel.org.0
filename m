Return-Path: <linux-pwm+bounces-2374-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C64090011C
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 12:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F322855F4
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2024 10:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FF715D5D6;
	Fri,  7 Jun 2024 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b7Fj+Q3t"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6C615D5A5
	for <linux-pwm@vger.kernel.org>; Fri,  7 Jun 2024 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717756971; cv=none; b=OAomyb9UX6NIdLKFIiZFAVnaebwpPKsPcVDffCihEwPgx4h+7qio6AqkoJdh76j883M9FKExBvQbVefd9Fkh8XpNQsfmJN7e/8uVthFATPt/AHukgj8W8VMRfvHzoLDlsqjBvhFV4+/IaS5uU/Hi8+QCfRY60k5QD9vhq1euG80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717756971; c=relaxed/simple;
	bh=DI5pyx7RMjaHZziGjHaa1vrJiax7OTZt8xgKgshZ3lk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sJiHpXiOr0gsFYu0CtcfR8FSHAfYeHD1tJO1+m1JFUeDiWCVuvud3edYlG+wqKYSryO1vx7BvJCzntbcUT8fuZV5rMwGHJCeMCs/ZRe7CX0mEaAjlJmir3OOVBmUtHu4IvsSRbE2AUDNCKvp3/PYttKBS4PfLDqDzBKc8ZK79XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=b7Fj+Q3t; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a68a4a9946cso235286966b.1
        for <linux-pwm@vger.kernel.org>; Fri, 07 Jun 2024 03:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717756967; x=1718361767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8D9Zkt2maKrtc59G380nIcY3mfw632QhZc2OU7gjB8k=;
        b=b7Fj+Q3tov5q1eDs3mvOlo9odAPDUON57eoJXo9j4gyIEfBzZG3c3MlsU1mkNRzeHE
         7ZAXujx/wUp5fu6kBh9u4lyoucM6LjCFwWo0kYTFVr2aP1iSIwvlnxglV2SbLPPjZEkI
         q57Y9fySDI7WN4O4ZSHwJfy68JQQYWKQTe7Fwe86+WMhklQhXdCpHwg4BB7Kx2cJcYaz
         BNolzEha82xawS+tTCuHudQfrzV0+I/Wt0h6vjRgFSRYDnURNvskl7KCjf/PG16WKekM
         hFjTprGMaftJ73Ef4zFfShp4rE9OZLWU54Mt6B3EeN/XxKC4hqcvN3klkcdFxdFvO5Oe
         MOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717756967; x=1718361767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8D9Zkt2maKrtc59G380nIcY3mfw632QhZc2OU7gjB8k=;
        b=tg0N8RQqylzSYE0GGuvT68ea21ooQxVyhG4D4hSWDPtWf5MkcSZI3xNmNlvc5/mS0R
         p6CODPz1o1cf7ODR0uTDGJ2FiMDzMIBCYzDa556lVUG39anTzchMN7hYJyOr5rq3GG6y
         MfEeBg0QYA9Hkfa/GUssP92AimMN65YR/fqiAqC0R5r/3j1oHtTsx5fc9Q1yFJ9TowD3
         8a81iBpU4RZr6KPoqEKve2d3BICmoK1TdWjEiBoMJavP1LdYzbiYSSw6ohSSItGSQmBj
         mrXS4d2+jjrqQ24OlH+oqk7dLHMTA+OHVBD9phrn1eEwlssjA01N0laa9KHbUQHSGwjd
         WvgA==
X-Gm-Message-State: AOJu0YxjKQkQgUWSNIjgkJlnMzGdWchdomHk2uItm0UO9bA0Fooe2w+b
	/ZzS1X9+6Hol0mGserFQbOmnZmtOxPdMpnafgngQqSVlscrffln95PwA7W5Br4lBNOJeBojtrVX
	KU3o=
X-Google-Smtp-Source: AGHT+IEB5gKQDLEl9lYX1VYgQHirn9xjmHJlKVDqUxjH27BTj+vPyV9dWlF4t1MliHBaUf/ylZrBUw==
X-Received: by 2002:a17:906:2355:b0:a68:ae1b:edbc with SMTP id a640c23a62f3a-a6cd675cda6mr151488766b.24.1717756966631;
        Fri, 07 Jun 2024 03:42:46 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805ca377sm226631166b.60.2024.06.07.03.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:42:46 -0700 (PDT)
From: "=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" <ukleinek@baylibre.com>
X-Google-Original-From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: Remove wrong implementation details from pwm_ops's documentation
Date: Fri,  7 Jun 2024 12:42:31 +0200
Message-ID:  <611ba758d7e9fb2695e96b23cb7ceeefb6ba8513.1717756902.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=DI5pyx7RMjaHZziGjHaa1vrJiax7OTZt8xgKgshZ3lk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmYuQZVJMt7FpplXN4iqtfoiOjuVL3mAsLpkChv aEnOdaDEI+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZmLkGQAKCRCPgPtYfRL+ Ths7B/wPcqfGzlD3XPcqq32IPvfrMhUdxOJRRlgwwOosMo7ERAK+yqjZyHrSFcq/FfKEoQRl7OL 223XWKWgNZlEDRjMv/t5QU0iNDzrAgPLDypaZFs5WlhYoGu0MHorxLJyZg2OTH0qxw/wBA1VohE JZS6WWizZQcq7fURzdczyZvNwSiTSKWMRUL2Aa1fskRvGMwwmI+GguJYOm/AQe6YwAKcua/873C rXPFj4C6DvVmeKCuR6msRJZNEJ4e6r0/Pp4DWvqThoG2mmimgZff0BJqzgDoDeyLStxoswy1Al2 kl+YFOh/O8f5g2voqOKejKWbiBIiT5NJ0oPLCk2VYCPzdWTb
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

When .get_state() is called is an implementation detail that
implementors and users shouldn't care about and rely on. Additionally
it's wrong, because with PWM_DEBUG enabled it is called more often.

Just drop the wrong statement.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 include/linux/pwm.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 60b92c2c75ef..32c2aea2a314 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -249,9 +249,7 @@ struct pwm_capture {
  * @free: optional hook for freeing a PWM
  * @capture: capture and report PWM signal
  * @apply: atomically apply a new PWM config
- * @get_state: get the current PWM state. This function is only
- *	       called once per PWM device when the PWM chip is
- *	       registered.
+ * @get_state: get the current PWM state.
  */
 struct pwm_ops {
 	int (*request)(struct pwm_chip *chip, struct pwm_device *pwm);

base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.43.0


