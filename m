Return-Path: <linux-pwm+bounces-7307-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CBEB56940
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Sep 2025 15:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2DF1797A0
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Sep 2025 13:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548162580F2;
	Sun, 14 Sep 2025 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgDbDHPL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C56D221FAE
	for <linux-pwm@vger.kernel.org>; Sun, 14 Sep 2025 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757856045; cv=none; b=DD99qGyTWa2vdW7RlZRcNkxFm0QLlKgKjl+J+y3IoEyUCa3nGl1Gv+w5V5TVdFsSiuhg9MCarD6CIAJtm/QFXZrhSC9/ZxbiXCP11ZpY2MvFZ69OWMCEfDP+TYRxgOrmmts222cjohObVea7nKWX8VoLLgqkeCVSB8l0iChLFxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757856045; c=relaxed/simple;
	bh=rruUm1ocHEpQZ4MUQAAECVBOSGcNHmVZdbgaderWfw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sXlDNDR1B+NPtw2kyBgIbz2b4lnQh8jy9KAAIjVQ969DMMgnLzYIVDhuceL4khcsvwKI0/GJ722yA5rm2Pp24Nt4nzHVEahEWHj9h29JHQB3OpL8VgmEFjFLN3BbSiyKfdmqXBPdGeRSFEjjlPLmDbvkMsmzSjioOLGfWqM1/0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgDbDHPL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45f2c5ef00fso2085325e9.1
        for <linux-pwm@vger.kernel.org>; Sun, 14 Sep 2025 06:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757856041; x=1758460841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kAG7m9JuJHlEHyVLrilF0p1L19ca1FzfGVRDxZu6tYk=;
        b=AgDbDHPLIqFZiytWd5LyzSqkMHtBXGA82UWkS/u5tJmXGD60lFGq7TejRYt1PeEfby
         1tXlPkygBsaoRHT2H9dJpYq94mcJBDqhC0dQ+fvJVa3AElH8oDRzmJ1+343jS1WHVT4f
         PHEzfY9Irqwi/KVpL47lU+Mn//GWVoZX+Ci4nmM+MyFJR/1afC1huJ1BMubPkU5KB+up
         /1niqx6GlwJeEnBqKwHUBXGMpJMBA0sohIw3ht5swibQ/rjzAgkaiw/F/Kj3LfR0FytK
         Ue1RTqm8TKvqPX+gZL8GbzZLR3u+C0HWHHSl+99/6eOV6j5ic627vthA/PjUbYM+6qWn
         kTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757856041; x=1758460841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kAG7m9JuJHlEHyVLrilF0p1L19ca1FzfGVRDxZu6tYk=;
        b=u/ZYuv0Vm0hREpCxjKPG4Z9zyNGrjAerm/+cDr6/kxTVDLyERW4p7aSIRJzvLAhfOi
         W/6pbAT7FyeLMA0tXreIj+K2LvUJYeJ22SfAOTmzBMZz5H5XvWuYk50Mv9n4pgyiF0C2
         bCx1HWdUXR6pbXoj0OQVQTIZk8Vtjem41N9HUhlo6W9gWsumNfnoDmK+lB39XhgQkjY/
         OB59JmJVhT7akjG1CMrWrtH7YlxrtxFNs7o9/FWS6Qmd6UfOVddrkSlMqsggPkmt1jm0
         3/TgykzQ2gI4hrGtYj+fxUdbj+r6+Pth6FAVRbuWMrj7Ob7VBeJDksW7RO772OhuUfq5
         6Ohg==
X-Forwarded-Encrypted: i=1; AJvYcCXM7l79Tbh09tMM5tPAuojVgCDYD8/JoXscP/A2Nuu+PHMQngbdNfm4SYT1IVh22PTEK2bbL3NPbN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH3J+cok7yqL8MAUcylhPLoUzyTgtBkgWD4NZzW95u5WwGSpc5
	V+uGOcLwHix76Q+115NOoYXhv39vGVY2I+3YW+/XmxAcJb/X5MwYvu+q
X-Gm-Gg: ASbGnct3y7uvMCG8jArKORgnxIIn3pn1D30eZaVViSYFCVNICoqtPO394CxxdNnTqDG
	gehFXdyLtmpJEPV+ew6R5LjOlmmm+6IQncMg82Zi6NsCmTeSidFqJM16V0gU+pMni4kPI8zlM7/
	xS9aFuYIJtlNckV79Rm+wjcwC1OULIINm8kX5jKGq1WMvf3CljQ8w0KClnszh9XC2sUtjnZyhcZ
	VLW9DBMIoGXrMyobpp+aTVvqfIPfk9N5EJgB9eASbfxUxYfKepyTXQZ8wX2Xwny6w49ia34wxGm
	w4VJFgbrz0gysm5Dipfq27Qyu4x+EMVeJBVKqD14SYyEBUAEo7xTbqiu9lUCwNHPtavybqcLK1G
	LmkNGCMClebNvaG8LSYXYbRi+81lQwAvLxoy10i+yIgHWfZIqv/mvHsS/6WAzlyNc3JWOELd89Y
	QHF8ASq87D
X-Google-Smtp-Source: AGHT+IGXHijtzVt4eJs2ZV02TN6C9aMKH+pvbvhPrJQNoOx9E+tCmvs9kL5J7Zm+EWTDt2YmA/iNKA==
X-Received: by 2002:a7b:cb87:0:b0:45c:a955:4578 with SMTP id 5b1f17b1804b1-45f211f7f55mr62938465e9.21.1757856040463;
        Sun, 14 Sep 2025 06:20:40 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f2acbeee0sm29595095e9.0.2025.09.14.06.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:20:40 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: pwm: samsung: add exynos8890 compatible
Date: Sun, 14 Sep 2025 16:20:33 +0300
Message-ID: <20250914132033.2622886-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add samsung,exynos8890-pwm compatible string to binding document.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 Documentation/devicetree/bindings/pwm/pwm-samsung.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
index 17a2b927a..97acbdec3 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
@@ -31,6 +31,7 @@ properties:
           - enum:
               - samsung,exynos5433-pwm
               - samsung,exynos7-pwm
+              - samsung,exynos8890-pwm
               - samsung,exynosautov9-pwm
               - samsung,exynosautov920-pwm
               - tesla,fsd-pwm
-- 
2.43.0


