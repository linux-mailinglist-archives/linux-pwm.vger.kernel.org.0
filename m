Return-Path: <linux-pwm+bounces-2630-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866DE91B070
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jun 2024 22:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB6DCB21FFC
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jun 2024 20:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9594819E7FF;
	Thu, 27 Jun 2024 20:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3atbTrhj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDD914D6EB
	for <linux-pwm@vger.kernel.org>; Thu, 27 Jun 2024 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719520315; cv=none; b=JDCKkFQ71NEqZ6HLUABKqibUe7JJ1AjwlFx7+zoxxKeW/zUIbVA4eneqrFondiezq0L78CXvhrUaqAqOwN8xvxhkchELc56zd2oCpnV++UJ7cPjf8T/B86wVN3k/Klh6RV7jFjTy8br0fJ8rXpZLQXXHYHDsVzPKpq7L703IwCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719520315; c=relaxed/simple;
	bh=iEIWZCVjVQKtRn7rDnf2p/Vd/JafHSjNKie6u2wtoZo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gHNBoN1JT8XyUoM9Bo02BGdNyPtOj1qEnJkijYUuJi+ALQ35eMypYV0CEnWqOwtx7EKsNwO23W+JmdOLSR3Dl2/vNGcdRJ5TFLBwDqisLpopgW9EJzTddlc1XpM4OX0T5y+EtGdE4l24L93/HI7BorbkHjfPOe/CkjI2kyk/wOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3atbTrhj; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a725a918edaso497055566b.3
        for <linux-pwm@vger.kernel.org>; Thu, 27 Jun 2024 13:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719520310; x=1720125110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OtHzH8KmjoZADW96XJ+dwPlkxs/BXUiYhFeA3cwmdJ4=;
        b=3atbTrhj8YtM6L8UdBRCC5FGt6zYk8SZx36NpGcCBwnQIbXl0Z6wm1IlhsUwcfYn8o
         HgosIJ5YUIJX0EIeZ7odiqjjeOmwQ5yZSVUjTztvx3QNNmMeAIoHu0qb5AoG9nmmrx3r
         iMLPf8dYNWVu3KRAuLWi3scn7sJc5LPIFPcgG7k/rRnbi8sBQc/YCKxScG0DI/WIN09W
         LJe/cBL7SBdlZpiMXctniXLWvfvyfa9DaFLFa2A9mU4vk2tOzxmkJhIq3M1dtc/XWlB+
         doEd4uFaij/Ig1L5VjGiZZms9SMPuCc9rEpXpF96zsVOTRTmInIIieKC/Q/5xXZ/jLJM
         dCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719520310; x=1720125110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OtHzH8KmjoZADW96XJ+dwPlkxs/BXUiYhFeA3cwmdJ4=;
        b=MH3Ya/YNOpGZb5QT1vZoeTFr7Ynv+7F4p/MmXAp4JzR7lk4gy4mPhG5hoJEL5NhUJJ
         a9XuiN6NN3OAxUTP4U1f9q0CYlHxqzI+NAWgFoQjsNan4QeBaeWQr6wUMY0X9II6mZZK
         iouE/YufNDL3gFEyfwjr5mJ1zbJC7qTtaGBf9kNxCT6ugRJieO7KELPMN1LDq2cSKL/g
         pC2p/Ue5sMlkjQdBItBigE6cu6FplqbJrp2Gpi8CPcrTX6ZoyA8qnUJ5xTjsf7F23kAh
         SSPHOTcU75Th4gbxrse05pR0NZUm1PoiI0lSkTVhhIMy2ze0QtumXX9vCqf/SYvguyhL
         eKqg==
X-Gm-Message-State: AOJu0YxSGpzCx1E0q8arJwqHmuMvoYXRLMlsLyMNZa30q2yki1qGvva9
	S1R3KMJ9MVDqMlPLLWQyaHA8Bwamt8OJqhlZfJvTX6HVlt6uKcDnIDperj/ddgYniwb0feLl8TH
	uGYk=
X-Google-Smtp-Source: AGHT+IEgSWxalBm+E/6vODPNxU8OYjsXJnfTSjQYc2TPttm9+dUvQ0DiYTSeLS1cO67n18JWlDdlkw==
X-Received: by 2002:a17:906:a847:b0:a6f:6721:b065 with SMTP id a640c23a62f3a-a7245bb25e6mr1081879666b.32.1719520309660;
        Thu, 27 Jun 2024 13:31:49 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf628d6sm9530866b.60.2024.06.27.13.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 13:31:49 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: [PATCH 0/3] pwm: Use guards instead of explicity mutex_lock + mutex_unlock
Date: Thu, 27 Jun 2024 22:31:18 +0200
Message-ID: <cover.1719520143.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=651; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=iEIWZCVjVQKtRn7rDnf2p/Vd/JafHSjNKie6u2wtoZo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmfcwhqXNJevGMn3Ia542qYrX2yxiX73yWYo6rH RKCsUsvdxSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZn3MIQAKCRCPgPtYfRL+ To5bB/9mJgGe49x/t6u39UyoBOJLwoDKj8k+woxFKRNMFmuc3wUSfb/nhsrnxggvAt30Ijo80AR rrpQI695SNsMzSE4x87pBBhslxUrDZyaWbQzPNMJdxsi8BDFoni4CBIbuzeT3jZ6G2yxVzLISpK zgs4eICbiubqM5sXuFRGVmSevTjCoIzEgOlFiEWJIU5M1sYlzhluIoN9BGoTQH1kRFcfBQUd9+P PgzCUXuICj7sjYPl48EgkV03naEhDhPSdDr8VJcMNCdwD2+Dp+UMWIFypDOLwNhoAsfNJLGjJwQ a8y5+k1gVxH+qTk7j3CgCQ21cpKf9PpGUvg1ZrQLdm8O/piZ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

I consider this a nice cleanup. It makes the code more compact and it's less
prone to error, because you cannot forget an unlock in an error path.

Best regards
Uwe

Uwe Kleine-König (3):
  pwm: Use guards for pwm_lock instead of explicity mutex_lock + mutex_unlock
  pwm: Use guards for export->lock instead of explicity mutex_lock + mutex_unlock
  pwm: Use guards for pwm_lookup_lock instead of explicity mutex_lock + mutex_unlock

 drivers/pwm/core.c | 128 +++++++++++++++++----------------------------
 1 file changed, 48 insertions(+), 80 deletions(-)

base-commit: 888564d8d708d1c91900ed3a11761f46297fd748
-- 
2.43.0


