Return-Path: <linux-pwm+bounces-3814-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719189AE278
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 12:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FDA51C21A7C
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 10:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947FE1C07DF;
	Thu, 24 Oct 2024 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EPXnIsbX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E191C07D1
	for <linux-pwm@vger.kernel.org>; Thu, 24 Oct 2024 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765571; cv=none; b=uGW5AVYPLKinOrmqt7FuaLzbjUlniMONIQwZsyRk0CzQM0lCsUwLW8nI1hqg4H9E06BGik13xjWWam4s2CS++fFEfiiCtj9PRJ6CsOakoVMG84SfMJkj0eQ2pOGn5/1mrBYsZVUwosBBSewIN/3E7kAjYrrsTGHB2wPz4B8vOVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765571; c=relaxed/simple;
	bh=iRN25hbq9isr2vGhOFjIxUP9FhrjBqw1sgFaQQysmIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O05klLXissZRGvVgGsXXdDB+E2AIUbhV+QQCFU+G4sh0cGkvnV+pOBe8ROX48BhK6WmTff0l5ib3iBPDM8o2sKxUs1kqkJKDVu3DfjvIK1652trw1/xxDBkMd9cB7cZttTpYeMwIm4ogKDHuxOAm+Pi+V3B9ZAS4TUa8DIoM7MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EPXnIsbX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so7814415e9.3
        for <linux-pwm@vger.kernel.org>; Thu, 24 Oct 2024 03:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729765567; x=1730370367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AhtIw+7BS/dFL1oM5W65aLz2my5+v3lTOv/bR89OF7c=;
        b=EPXnIsbXy6IbIMK7X3tKLZ0E1Bl70cv06p6F5hEjmqI3iJmX9oPs41j4UYugiuy9vL
         Dp1ws3pTZpgMrYCX0kh0dLdOPyGJZauVAwQmjxPguctUdcIkHyAE1SJkDjw7YaIebPWE
         4ymnNHbSM3TK0DFcYYi+04P+L35gRSxeQ4ddFODvDbnKCWMFBaQ/WjLsOFrT7UUPyMnA
         90Pvy6mJYIp9Uk1VVzQJrqe3ntOhKSDk64AQfi7C8kKFY8ZPXmdnyvXQt2qMnI/74q3a
         pJca+U5OzLhESYMGzqM9SI8DMLmkdxTogaluYKImIbL1GkUCpoJwtOtxjvLs5cJIzOZc
         +3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729765567; x=1730370367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhtIw+7BS/dFL1oM5W65aLz2my5+v3lTOv/bR89OF7c=;
        b=NtkI+BuasMo8r6Zufl4H/kjDI4E62nGOY389siG7gjEwSFKhYHa8X8il5ay6U4Fk9g
         PMA/r548cfk9IXz8hYTAn4I5fRBpfkpqk8Ee6ddK6OFd1czC0Czq7PQCAf5+QQVnZBhz
         y83v/hBqIFcROL/F6LhvRAyoT+4FOnt1QP2FmV0GP+I2bJ888BN1A1FxEKW/AdzRkvrb
         WKqphVEn1mZSkOrrHM4cVUNJtJLuqDAlmOnDTaKAcsgrsXyj+Cs1ifvMKVe4/+8BbuaF
         A3Yp/cOQC6flIntHeYnXnkFMvntjgCLajP0/i1dNJ+HYWA8RM+bAk6h9gXmHMCWl1yht
         7ZVA==
X-Forwarded-Encrypted: i=1; AJvYcCU/lkavY8+vx1IOvmlSacDaNY3T5XWwIE/py7T8N/Gc6ZMVgF1IL4ofUvVwIS7DwmmMfBWGSIBo2D0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDm+PUi4Snkhm2HsiVSekmzUWFjhMcJcOJIxonwqdnQDz8MX+P
	ba1AIzH2qcNdNyzL2Dxy9HP9x4CRFtxaTJjomiIyrpnsrIxHYnh9DVz4QzHpL7k=
X-Google-Smtp-Source: AGHT+IEFrTpjs6ccg0ujM3/hq8Q11Njdv1GN4F0C33j/+FAYCoqsN7IcxEPS6zYw4ZiWUN2NcENe3Q==
X-Received: by 2002:a05:600c:354b:b0:42f:75cd:2566 with SMTP id 5b1f17b1804b1-4318c6e902dmr12229715e9.2.1729765566736;
        Thu, 24 Oct 2024 03:26:06 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f719sm12920965e9.15.2024.10.24.03.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 03:26:06 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Trevor Gamblin <tgamblin@baylibre.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: pwm: adi,axi-pwmgen: Increase #pwm-cells to 3
Date: Thu, 24 Oct 2024 12:25:54 +0200
Message-ID: <20241024102554.711689-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=iRN25hbq9isr2vGhOFjIxUP9FhrjBqw1sgFaQQysmIE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnGiCyGhgcoDpdCu23e8uYL9nba1LiPG2eEQgrW ZVPfHy0KxiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZxogsgAKCRCPgPtYfRL+ TtB0B/4s6ECnEjyhTSCcoppxlS0gLJbm+vScWDR88cUX/oGYIp1PRkpMCWQUx4jSOKBhwrMiq8q 3qoIacfdbjxnF//Yrc535tqsBVaczqgFSq5SdkmnLtpX67fw00VuOMd8JW+e9dcGOHaXmzi/kt1 ku8uA153ZXhjqWDoynuvjjmIcHuNPFPX7uQlyEtbSS4MxjZBWWQQa28SaPBfir5YzW8N1eVfZHU gsngxYaUjzUJbUiKFnWtGkpue3Eg+oQ4X7USj/Pf3AzUPHd/ijcxccgftQ537cgIX4YX8+jnvEJ hkH4C1JAGroAUIPeSob8xWJ/nRHFtz58a6/dGvNxe4z6g8sk
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Using 3 cells allows to pass additional flags and is the normal
abstraction for new PWM descriptions. There are no device trees yet to
adapt to this change.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

missed that during review of that new binding. Just noticed that now
when (internally) reviewing a machine dt using that device.

There is no need for driver adaptions, the pwm core handles both cases
just fine.

Best regards
Uwe

 Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
index ec6115d3796b..aa35209f74cf 100644
--- a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
+++ b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
@@ -27,7 +27,7 @@ properties:
     maxItems: 1
 
   "#pwm-cells":
-    const: 2
+    const: 3
 
   clocks:
     maxItems: 1
@@ -44,5 +44,5 @@ examples:
        compatible = "adi,axi-pwmgen-2.00.a";
        reg = <0x44b00000 0x1000>;
        clocks = <&spi_clk>;
-       #pwm-cells = <2>;
+       #pwm-cells = <3>;
     };
-- 
2.45.2


