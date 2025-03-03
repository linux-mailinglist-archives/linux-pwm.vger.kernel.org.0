Return-Path: <linux-pwm+bounces-5029-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A108A4BF67
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 12:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389BC165A1F
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 11:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DF520CCDB;
	Mon,  3 Mar 2025 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UshAcp70"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF82120C02F
	for <linux-pwm@vger.kernel.org>; Mon,  3 Mar 2025 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002794; cv=none; b=OpcPckMPSpmD7WrXjN4ji8lDirEClgQHhOBUaeFlediyfzQpV26xPtbI6x6NWjBlB9SCdd/zicVYp1rO1Y/WPNXDO1KGpDDbiF++AjjkQM7eIdc03AD1JAbp0EntuhjpeZ7igXBM9Ik5oWWuRSR9cpIKUIb5+SdbEW6tQ6gFPH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002794; c=relaxed/simple;
	bh=weuzDKCsQiMr3iqm68yFLz1cNSwdbqWoaxOIGm3Qv1Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K2yFmthWCIurf08UfJTiA9UqdyrkBWApTnhrmdCYhu3w+Bzb9CpFYq2h1PLV7UEcT8c0Pt0ex+ybLmUXz5ukwK3rmyoVPtYkFmQGNwTbLA/9Hq75F9lAZ8NU7kSrcNOmopXVWRKm6EMdLE86w5pT/AkYK6gV516hb7C7YMZ6bEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UshAcp70; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abf48293ad0so349097466b.0
        for <linux-pwm@vger.kernel.org>; Mon, 03 Mar 2025 03:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741002789; x=1741607589; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yFk+AUCXrKYMFB3jOa4VTmIBB7qGuqY5Tz3fdWlt8X8=;
        b=UshAcp70bwLfueH9nQU4muj4dZfypc+TVIiBCwvARiyGQTMstAhK+bg5aQm6zCbylC
         3VRUuzd26k3HJG+y4pInEjxD/RFGMM46J93wdtQB3n43RfCDy5/qgv/+t/yZTfe1WpOA
         oU/nXM/Mu5N2GSeexZIUpMbl8gs1L8ZAVBhwb+5g+HgcbeaUuNzwqpflt7T8iSKTlzNY
         DCx5xQp6Ii/vHUz54glYaOS9nN/ODF/lPZzfWQZVUs3j7C6+744DQxEOS4YKrF7gacxp
         6vWZupHktV74iEzh4NBlHRY2lC/PB5HbwCpKAjrH2yMyujbps4qAnTOTgQJ/AjgnVT7t
         wW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002789; x=1741607589;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFk+AUCXrKYMFB3jOa4VTmIBB7qGuqY5Tz3fdWlt8X8=;
        b=quVnDqfX9BsvBm6V/aUqf0RlFOAmSw8G6eOh10DlwVm3ksTa+P2yYEO2Qs5bYtKdV9
         0GZTWEZ7TmzZYybFypGV2Fu69QWchCr8ftYIvQF6aM+u99YbSA38pUEy6ckp9IW7ZDEt
         mW8BrI/LUPZxn2ZZKgtN/b4sZRLKGAJA3AAnD6vu/puYQ+I1PAK4P7HCX/V4bFeUwqWc
         4zG7pI4qoLVwknfYRt0I+QXWFcpZOFsbIqTzzwHkfoD0dc6qARovk+P6imx68jGefKGp
         QpKpX/XjEGXrRjDb6N93dc6MXqay3QlUT69cnpon3qgrWylL1OFfodZ6XnvvHqu3sspC
         YHcA==
X-Forwarded-Encrypted: i=1; AJvYcCWKNjzEDbFxtSHnSbBjiMGusaZ20W1mbpS1OjBaAgDxfRTRbj74o/taa2EzAp7zxrou3UnJ1GrB3qU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYD4SaWsAv4X6enhIpI+vluMJgVoF7tfTpx0BPnuDFatLWedf3
	EFEJQprzV19JiQlAWcJxPhxrsGdkzO3KZN31/2zl0dR6bT3uMVT8d0uNecz6fPg=
X-Gm-Gg: ASbGncsP0g35p69ELtbPyMWyQFfqw33J931PApo3SQOgl89VZlHYp25/ygZSONO+6Ab
	uSEEVQ8x9d0XsTW/bHibFVM/obF/9RzhSCECT3eBrhCjsuf9pTE61yOTsb6/sI5oupuF6cDdqTr
	3nVhMbuQSZLDyif5Fys7EzawH5ZSyFxBmEslgM9txFoG1ap6HN0CRfhYJIIztIWkmnroG6hRXdt
	corvSZqpTJ0CmbiBQfOfUMRGvjXdJ1MJUaZTw2SL1Tes46h3GB5Z5ULwQ+HIGOFcBRf/jdCzz05
	2/9yYTlUJ0cVV4LUd0ojzQ8ZRlUUI3Nt+jaE598Evc4=
X-Google-Smtp-Source: AGHT+IFEhX0K2m/xxoCepy05vSD+L8QdDqMDgYEprV1OF5Vyr84x+ua4osWWJ20v8KKeG7laOTv8/Q==
X-Received: by 2002:a17:906:a389:b0:abf:486a:5e0e with SMTP id a640c23a62f3a-abf486a6354mr945646866b.22.1741002789119;
        Mon, 03 Mar 2025 03:53:09 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1de83fa49sm86833866b.158.2025.03.03.03.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:53:08 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v3 0/3] leds: rgb: leds-qcom-lpg: PWM fixes
Date: Mon, 03 Mar 2025 13:52:49 +0200
Message-Id: <20250303-leds-qcom-lpg-fix-max-pwm-on-hi-res-v3-0-62703c0ab76a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABKYxWcC/5WNQQ6CMBBFr0Jm7Zi2BoquvIdhUWGESaCtU4MYw
 t2t3MDl+/l5b4VEwpTgUqwgNHPi4DOcDgW0g/M9IXeZwShTKmMUjtQlfLZhwjH2+OAFJ7dgfE8
 YPA6MQglVZam2tXH2fIdsikL5uFduTeaB0yvIZ4/O+rf+5581anS60tRWVpErryN7J+EYpIdm2
 7Yv84jMGNcAAAA=
X-Change-ID: 20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-067e8782a79b
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Kamal Wadhwa <quic_kamalw@quicinc.com>, 
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=weuzDKCsQiMr3iqm68yFLz1cNSwdbqWoaxOIGm3Qv1Q=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnxZgYd2y1ePd7e26DC8gF6jUr1+KlcJIjfd8Rr
 zgdzdceoH+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ8WYGAAKCRAbX0TJAJUV
 VkIJD/0Q409NWJSNEHd+fCoQUYi0dSBHe3lxpE/IltreHBhmQv0actfrY25E4+jsyQgnRmejHuL
 xXae9PGPduXBbUH6+311xQazz/EcbttQuBeKA6FAjMW7hPohIzKojja4+D45PAzsOEq19tGjDca
 V/hep0WSJLaQfQ3CidSpene/fo3civL7WpPhfvZcWy9EnGLwBiczgy6hp8ox7BvBqENxEYu1znc
 Tjc096J++kZLATDklZ3oCwfiV++d/uJ4ZPGnW1jGGYgquNWNNTp//joJ7ZcbosTZsIZTZi8Co60
 QzxLrla/Ivm1+gqj1dw2djEY5zcBPQwltu7aEnl8ko488C6TgcQtc0TS8QeJhA/1A/Rz0NAnYCh
 eTWS5a0tMeUJfIbjN46F2Nyua1OpZP/d1pwSNj/jwHfamKaf2odzjwKV2C4Rf/3ksuucDdDwYmu
 Q2migLWKqqrbmwLq09xAFlYwXMDb2EoL34zT7lLpKUEYXmZFxR8E3i/JWpgxswPn1eP0rT+as8k
 LxSqfhNfbudOJwoAU/GCpNCnd5rw7tdkAejXR1bqqSu4XQ8XuYb3kiaakvdq+JwJ1+l1mpcShOd
 ROxTRZmNbPv31Mg64AQsmaOl0jSUjMrlfSf3hilAlAX2GGU1WkSRILclJP1GSekX5C7Me/AjEpS
 OF1KY1ALG6rJnzw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The PWM allow configuring the PWM resolution from 8 bits PWM
values up to 15 bits values, for the Hi-Res PWMs, and then either
6-bit or 9-bit for the normal PWMs. The current implementation loops
through all possible resolutions (PWM sizes), for the PWM subtype, on top
of the already existing process of determining the prediv, exponent and
refclk.

The first and second issues are related to capping the computed PWM
value.

The third issue is that it uses the wrong maximum possible PWM
value for determining the best matched period.

Fix all of them.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v3:
- Added a new patch that fixes the normal PWMs, since they now support
  6-bit resolution as well. Added it as first patch.
- Re-worded the second patch. Included Bjorn's suggestion and R-b tag.
- Link to v2: https://lore.kernel.org/r/20250226-leds-qcom-lpg-fix-max-pwm-on-hi-res-v2-0-7af5ef5d220b@linaro.org

Changes in v2:
- Re-worded the commit to drop the details that are not important
  w.r.t. what the patch is fixing.
- Added another patch which fixes the resolution used for determining
  best matched period and PWM config.
- Link to v1: https://lore.kernel.org/r/20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-v1-1-a161ec670ea5@linaro.org

---
Abel Vesa (3):
      leds: rgb: leds-qcom-lpg: Fix pwm resolution max for normal PWMs
      leds: rgb: leds-qcom-lpg: Fix pwm resolution max for Hi-Res PWMs
      leds: rgb: leds-qcom-lpg: Fix calculation of best period Hi-Res PWMs

 drivers/leds/rgb/leds-qcom-lpg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
---
base-commit: cd3215bbcb9d4321def93fea6cfad4d5b42b9d1d
change-id: 20250220-leds-qcom-lpg-fix-max-pwm-on-hi-res-067e8782a79b

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


