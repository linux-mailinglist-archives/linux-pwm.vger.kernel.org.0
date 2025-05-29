Return-Path: <linux-pwm+bounces-6176-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE00AC813E
	for <lists+linux-pwm@lfdr.de>; Thu, 29 May 2025 18:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD414E5081
	for <lists+linux-pwm@lfdr.de>; Thu, 29 May 2025 16:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8963D22F155;
	Thu, 29 May 2025 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RgcOU+NP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719D222DA11
	for <linux-pwm@vger.kernel.org>; Thu, 29 May 2025 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748537636; cv=none; b=Fqyy3fE9b/Ly4qeAGax78GH/vMwVq5PB05PDXEyDJUe64ACaz0vrBrjejqsiA1A9pf8a4Zyg5QzcZBWJWgL0mBmnhQKTPJ1BV0pzD8JwDrWqIlTN1G6Em0AHiG8NUToZzGeyMbHiWgTdDDUlL4FXB0vyLW9dKYaxKDksFCwBPwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748537636; c=relaxed/simple;
	bh=m2++tAofmXWGUZrY+VkUzUvQUkMhh6m/iSTYLIecuYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NhdVGU3vWuXQc7M1UAv8hsBmLMbVO5Eb24Zxc2+dAf2fJMb8ilSTJ3uNlNZSqLl6Mnq71zRQGt4lm16wwj1pFHNtL9i9l1cpy4lsUWdz+p/stOdEorNY98ETOvUde+aidvl23qAUn3loP2LNq9An/icn8y2Zc9QoWc1QltClGNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RgcOU+NP; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72ec926e828so293014a34.0
        for <linux-pwm@vger.kernel.org>; Thu, 29 May 2025 09:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748537633; x=1749142433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dvZkXcKyoi2ZArZGC/DSueRrfUVGqS+N3BatqzSSLnI=;
        b=RgcOU+NPgs6AqqBJY/UiwFmFe8P1fDbCoHR0z86lAquamsSKcAruCDgG5nRUgDS5ET
         97Eycjvz3L+vUcpkF0OGwQN9YaMmjRAjl8tAn/n7C2myN91Xv5o6lHHPox/4SJwNZrb3
         CO5Iu6rxQh43YgMHKRMTHC0K44aqGY3msR3WIajDAVxzoRj17A4iQayJQ8SLCRokQrmP
         traVYdhIyanH94Vf7YTtXkxn4l5Z7wxSX3438tA2ACsZzxxhRJWA1obrRENVNqTrrHjV
         vNWMA8VftW57OlqosxrBcb1UZUMaCyFOGOW+zLPUCyAhvSl1sQ1U1l7JFEeI6vMIT7DK
         fc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748537633; x=1749142433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvZkXcKyoi2ZArZGC/DSueRrfUVGqS+N3BatqzSSLnI=;
        b=WBoEu1YgsEtbS94df5XBbUylkF7YLj4wkPFO5twViTeyZAUzheNvznH8XWUMWiUsam
         HTDxqkU3tA5XY86Y5Wf3IAZwkDoIic2i6XttWg/Df1SlM0iwMJJPubV7jwJ+cu4z/xC/
         Cpoqf/Zeqz4h5iv1MuAQv+SbYcVF0b4FxnvKhv6UDujT/x8D4dN4n3gQtLQ5NQiiN0fh
         kuVvU9om5RC6WTIDKADTvIXZt4qKbHLJW7OooCd+4mIiZY7ChdPotSh2+2vVi5KBfiqf
         8KY+shAxGMdtFmHg8l1zvH6KOhpRDWmbEPY2b8aMg2NpXb5mBHETTjBqLok/JE1jcq+R
         w1+w==
X-Gm-Message-State: AOJu0YyAeBGJEp2GCfVaYy3S39OO/9tvx5fnHT1hwNX6sVEQD7h/5/Ik
	pU0Aux6hAbpmsw39icoKtYhVaAVZALyDcXi01DMofvs5UBmAYNgoBJhjAJTXXL2PDIc=
X-Gm-Gg: ASbGncsXTx08/QJg9XC5LyQVWNV1Bt3GG2j9nVGL2FroZZ2foxsPE8xS40WwG9I/KNb
	uMQXQWmhWW3BjT8DJAMkorQ9rvFh8IC/xEdnBzSB2BX5npQU3WR7eshyAn9rYLgFkpeCIVsZFfY
	U+yv3IaCjlFgsQrNNvhVn9fwFHYMJwFtRRFiMpWnbC/+2oqYxcoiNkDTGi/A3wkyxOtD7miYMrP
	9eXTVpdjJoHFRmeoCGNaRKr60082/0A/scqmvZix6kJm+60JJ3kWAMkUfGmoZQf5EqqnNIC3mHL
	9/PChVSSNtHyrUxbfXeGurGVMegdzkDPmSiI1U0EWJooUDDMgL3W8jKA
X-Google-Smtp-Source: AGHT+IG4fIZm0J6PMyZg22loZMmxJxYbkdzOAE3YNy3sBQoYUzpwZdMfEk4mmrj7fzK98RObdcEQ9A==
X-Received: by 2002:a05:6830:3c8c:b0:72c:3289:ab9e with SMTP id 46e09a7af769-7367d61d9e0mr4418a34.27.1748537633425;
        Thu, 29 May 2025 09:53:53 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:928b:5d5c:6cd9:1a4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-735af82d2b8sm303265a34.3.2025.05.29.09.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 09:53:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 29 May 2025 11:53:19 -0500
Subject: [PATCH v3 2/3] dt-bindings: pwm: adi,axi-pwmgen: fix clocks
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-pwm-axi-pwmgen-add-external-clock-v3-2-5d8809a7da91@baylibre.com>
References: <20250529-pwm-axi-pwmgen-add-external-clock-v3-0-5d8809a7da91@baylibre.com>
In-Reply-To: <20250529-pwm-axi-pwmgen-add-external-clock-v3-0-5d8809a7da91@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1887; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=m2++tAofmXWGUZrY+VkUzUvQUkMhh6m/iSTYLIecuYw=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoOJESup4Vmlos5i9b6wR3bA0dBPjXStd6d95Xo
 IJODVKd0lOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaDiREgAKCRDCzCAB/wGP
 wBV+CACOeHYAly2vTDSLtIbL22NA22l8/evjmXjwD2P1B6H6UPo7QhMTVKN+99BexVf7i7pOJtX
 G9Sw6czICNL7IkFgXXIyP+6lrfKkT9GUrzcG/PUuLMErfgnwEappBbRN5bxmXWrZhzzh6jrS7R1
 UFXtfTiSGC6EzEzml4l1qdo4T8Qq4fBnyQSKfJadKznzJmKlxpWNeFl3NOM91KZwGIk+x0WMejS
 ppRJDUwju/0c8EiczCJPYaBV+tEvS3OZlYvw7id5gKWsZL1ibtnqFbSmAZer11GrfQ1PsWBpmox
 brCXbRfbYz/G6/9eCzzA9gkyGvJ5UPPwK6HMJ2Q4H2DlF/4Q
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix a shortcoming in the bindings that doesn't allow for a separate
external clock.

The AXI PWMGEN IP block has a compile option ASYNC_CLK_EN that allows
the use of an external clock for the PWM output separate from the AXI
clock that runs the peripheral.

This was missed in the original bindings and so users were writing dts
files where the one and only clock specified would be the external
clock, if there was one, incorrectly missing the separate AXI clock.

The correct bindings are that the AXI clock is always required and the
external clock is optional (must be given only when HDL compile option
ASYNC_CLK_EN=1).

Cc: stable@vger.kernel.org
Fixes: 1edf2c2a2841 ("dt-bindings: pwm: Add AXI PWM generator")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
index bc44381692054f647a160a6573dae4cff2ee3f31..e4c2d5186dedb18701af74bbc957b82a2b0f8737 100644
--- a/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
+++ b/Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
@@ -30,11 +30,19 @@ properties:
     const: 3
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: axi
+      - const: ext
 
 required:
   - reg
   - clocks
+  - clock-names
 
 unevaluatedProperties: false
 
@@ -43,6 +51,7 @@ examples:
     pwm@44b00000 {
         compatible = "adi,axi-pwmgen-2.00.a";
         reg = <0x44b00000 0x1000>;
-        clocks = <&spi_clk>;
+        clocks = <&fpga_clk>, <&spi_clk>;
+        clock-names = "axi", "ext";
         #pwm-cells = <3>;
     };

-- 
2.43.0


