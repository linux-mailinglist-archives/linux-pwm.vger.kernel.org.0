Return-Path: <linux-pwm+bounces-6978-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 337CDB1FBC3
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Aug 2025 20:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AE9A7AAB36
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Aug 2025 18:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E291F7910;
	Sun, 10 Aug 2025 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oA3TPUAz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0371F03F3
	for <linux-pwm@vger.kernel.org>; Sun, 10 Aug 2025 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754851973; cv=none; b=cfmBbsgBO9PsoPq9B1asG3v7KlSDfKASnlkOTnGiuwdy0i2kb4UKx31nVWe/0SV+bUYYrbAUirDpvhdhGZbl6rzE9r+/eXG2oFSetjXOuCjNSOC10hrcPXxsmgbQDI6Ro89e336pA6/QBmsBebUN92SuNF53Yjzg+gTP9j01YWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754851973; c=relaxed/simple;
	bh=dRZXfj9LhZMEywUBc7ebwIDMm4+bg+qctwAOluXIk/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jzN4jJvVr10DlszKOXHD591kS5JLhpc/x3ujZ9SwWSZ5Yv4KEnzggGpna1a85Cn78LzppGdjs9WwgfbzuN+nBQdHWRkBGbjLeYucRTmiStGjt9Ic9eCtcK41qM5xGCDiW2LqLyvP8PgFkx1qZvY1VGcszZyzbTyErNBflUQxrJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oA3TPUAz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-454f428038eso33799485e9.2
        for <linux-pwm@vger.kernel.org>; Sun, 10 Aug 2025 11:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754851970; x=1755456770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=usyaukZJ8v2Y8S8vh0sfNK3CloCXi6WSzcXm4cRl3cI=;
        b=oA3TPUAzBw/EqnTQx97GTVhy3K4ewX+jy2Q9LHGzSaVmn4/T+FXSIyZIqTexb4YYSO
         5jSsbur6y4vjOvW42EZtVTM0PisqF3/d6d3Fy0tam/87tkalXaVYlJnbtEFByV1pyTxt
         8Qv/7HtUSHB0+ios0K3ywk2403OXUxBRXe/1IMzONHs4L6SxqUt4X7+v5B2oYa7ZhpWE
         32YZoGCtBZGgC8Y2HX9iifGWRygSC3st9FP2JdrXHqC6KHsDHoNaSID28TH8z3+6IK/D
         o3ASKCbcLJ0QSrH8DDRjXczanyudlBV5bvWxmnpgKg17nlCjbr23o8c+jPBJZYBlccju
         dtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754851970; x=1755456770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=usyaukZJ8v2Y8S8vh0sfNK3CloCXi6WSzcXm4cRl3cI=;
        b=Xtf6HOyUWx2gaCi1zTkGf62U64vSv3gjLzJUovBgvyTju2xP2UqoxRZb730rRFh97d
         lQ6JvhJQV6/SaREhXCt+LJnhr0mrXqwZ9IKg6znHXz+4APMwFLXvN119ityIbPdzDIGZ
         8n1jGtoA6NseeOKJAgqIzDAta4wmx7jMcV1z5GzAeKRmw1hvZJ5/Q8AKPLjY2cLCdJs6
         KHyAKa9MFFNpgN8oEM4clb81BBlX+GuG7t5ao5II8aDmOSgS39xzZcfeayLBX1fApH8X
         isX6/bD/h3ZF13qtZC10N1n4dMAv/gkkcVnBuDjj+d0FbB0Gvv6bTZvo8SX7P705o45A
         kvjg==
X-Gm-Message-State: AOJu0YyG0IuD8QfBr2EpL5iP/I4AjvaNVUrwiY6RKyWruGEdFWLiXX6r
	/l/95J4QRdgEt/xhUIcp9lVJeVOOPOMmLoL8v+5ptbBtg5UHAY0SVPl3Pn7KdKXmnEs=
X-Gm-Gg: ASbGnctl3P8wA/zQxNxpy6BcvpFEQPkTbpHc6f5jlFMja/SyF/uXCrP8MvJnKvqESe8
	jnEnvAcyBlRI0215cmki/eqM1eODWGGD/98ku1rChV4SrOp06qzdfZn5pabk0SRLVEf3zzhbbLz
	iALte6pZkxbM3rwNyL4GLqXTzA1DW7rrzWdVKFIkJb0+Zp3EKtswIDFPYygI75g+KZWOCzqn/d3
	08bXOz+AUARONPlkvwftBtJcHhSr82AYxj1RDBSz8n7V00yy4cnS9o9h6hImC5voSvKhvhCfeSh
	rVq8ycO4nSLfloucGnT5Krhk2c/bQA5rGjdmWzpKHcSY/p0lE0lckblLcxn227mrA2g7uY4e4R6
	lf4dgW0F0wMmN00Gj02ZkmMDoTjiHkqK7M/44YY0iOAnVPDcMBxPvXkmhikI=
X-Google-Smtp-Source: AGHT+IFeTAPP7suUMfpcy6xs18xcCXvs6tFgkRdUdcK+N3WIVE5vhGpvbw+GdxaOl6/QKV6UOXPNGg==
X-Received: by 2002:a05:600c:a03:b0:458:a7b5:9f6c with SMTP id 5b1f17b1804b1-459f4eb4d05mr88238015e9.11.1754851970069;
        Sun, 10 Aug 2025 11:52:50 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459c58ed07fsm319461145e9.22.2025.08.10.11.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 11:52:49 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ghennadi.Procopciuc@nxp.com,
	s32@nxp.com
Subject: [PATCH v1 0/2] Add the s32g2 and s32g3 FTM PWM support
Date: Sun, 10 Aug 2025 20:52:16 +0200
Message-ID: <20250810185221.2767567-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NXP Automotive platform s32g2 and s32g3 have on their board a
FlexTimer (FTM) dedicated for the PWM. The same IP is found on the
Freescale Vybrid Family and the i.MX8 SoCs. However, there is a small
difference with some registers not available on the s32g2/3 and 6
channels instead of 8.

These two patches provide the DT bindings for the s32g2/3 compatible
strings and the code to deal with the FTM difference.

Daniel Lezcano (1):
  dt: bindings: fsl,vf610-ftm-pwm: Add compatible for s32g2 and s32g3

Ghennadi Procopciuc (1):
  pwm: Add the S32G support in the Freescale FTM driver

 .../bindings/pwm/fsl,vf610-ftm-pwm.yaml       | 11 +++--
 drivers/pwm/pwm-fsl-ftm.c                     | 42 ++++++++++++++++++-
 2 files changed, 48 insertions(+), 5 deletions(-)

-- 
2.43.0


