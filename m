Return-Path: <linux-pwm+bounces-3727-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A619A4A09
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Oct 2024 01:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC7A7B2211F
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 23:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EC618E758;
	Fri, 18 Oct 2024 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rnm7Nt4m"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522DE143888
	for <linux-pwm@vger.kernel.org>; Fri, 18 Oct 2024 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293775; cv=none; b=L4qXDTHe/B2Keh7WPBLglRJmT85GKKk1Lhna/XrjM02Rx4mkYLUf0ai1wfLeoVvonJxAUrO3UkvlIQ7kXV/FyW4pmJtKgr6C3gB4M5vsPG9wwaHSVUZ5BAqjlu3rpnqkSTfwD0EZS9e86F+YAON4qGx5EiwV1oaxRw+2aHfpyi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293775; c=relaxed/simple;
	bh=yVi2CBHNTAXqIwEu0lUukboe5GQpHdaPjfgHBK2A19E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9jl85oq2LGBo3B1QFQUrd1vTFaW9aDzGQ06r9sWOkgxKf9natOiPzv8R44iSa5ahfnvy7k7H6iPuKk7DMofiCmtaAQPNwFQDcBjhhk+5izmo0i7VvCGNlh+G9x0ktwVHv8EnC4K6N6k/0MCkeAy6QUWhyfCFA96sPKEpukngU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rnm7Nt4m; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539983beb19so3040811e87.3
        for <linux-pwm@vger.kernel.org>; Fri, 18 Oct 2024 16:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729293771; x=1729898571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aX1Ed3MLmjAUFYDzujQv0rzYaNVm2pPy+pKKKWr8v3w=;
        b=Rnm7Nt4mCOySYcrR+YMh/ijWbfPEagDP1fInUztXM/0KWsadaYchwwsSSHdJw4Hk7+
         JDojCaKz57vtogFZM/rZx7cGsphURzs7NTpl69vPHaLUv73ZhPgk1anVyuD9Ow5LtRRJ
         wk25NRujxTFXg7WNzXXPuneKy55ra8yu9vyPWW+VGGXL/KvU0WFlRqMjBWvBmvr/01Kj
         wf5HR9XJGlSCQYX4m2eIDsljO3Er60ryxdOeRCYi2S+kxKbEdAjtvdCBJNLnJjGge9dq
         PzD7KRDu+T2yO7ULjYpwzunwCmfcnwh69vfdsb022ZH8nI12QAK42iHfTFeyi9Zlmuak
         8O6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729293771; x=1729898571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aX1Ed3MLmjAUFYDzujQv0rzYaNVm2pPy+pKKKWr8v3w=;
        b=XY4rAhyyWucQzrrszKgVahudyC+iD2a2OYSuSTMg1qGcfCfC+IIeYDKQRJFZMk+xP4
         mfqJN9zdifKniXwlzXevqKHZIvCSS92MWjiDGvAqrAAp6o/2jWIwdq/HZuRfyTO0ze9B
         KA92RoDjben6rUsyDL0n51kxJnda8bWukzIMvUNnTvBesC2ipAhFDF/xPK21TDq7p742
         JKV5BYlORGbIeLVV98g8+rVZTDhfGuAsbdIuuvkfXCa+MBhOI+m6RYBPDzrr9i4jEtD4
         uW4wwHx6drY7jGRxvzuXPrXniDIXOOPTorsS8aB6SlfR6SMe9n5+8a51hlNH3r9KiBYg
         Tu8g==
X-Forwarded-Encrypted: i=1; AJvYcCVgN6jn12kSWeiOZJKGwYSopO/ulJgOuuweBzddVkbGeqwgFHAFLCq1lQ1eL1xpwj7vziM7Fi+cnXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl4NRjxDHREN3Myp7TtjCRfOzdh5S64JIpTBtLX/Q2JDmVal9c
	CT1OukB2ce9awM/j8NKU8uCTDnUASgqL8+XASZ1GGaUEig2PMW5klmi3xuwJd74=
X-Google-Smtp-Source: AGHT+IGyfftMjWZHfQWKqWoQYQ8JI+p/ypISrL5eJ6+gCuABF4WiTfoXGbQLBF2l4svs55N/Vw1Axg==
X-Received: by 2002:a05:6512:3192:b0:539:fa3d:a73 with SMTP id 2adb3069b0e04-53a154e7966mr2320766e87.39.1729293771084;
        Fri, 18 Oct 2024 16:22:51 -0700 (PDT)
Received: from eriador.lan (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151b9151sm349825e87.75.2024.10.18.16.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 16:22:50 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: u.kleine-koenig@baylibre.com,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	=?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
	David Lechner <david@lechnology.com>,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	Alex Lanzano <lanzano.alex@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v11 0/2] Add driver for Sharp Memory LCD
Date: Sat, 19 Oct 2024 02:22:47 +0300
Message-ID: <172929376314.2587927.2624699121778996381.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015230617.3020230-1-lanzano.alex@gmail.com>
References: <20241015230617.3020230-1-lanzano.alex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 15 Oct 2024 19:05:42 -0400, Alex Lanzano wrote:
> This patch series add support for the monochrome Sharp Memory LCD
> panels. This series is based off of the work done by Mehdi Djait.
> 
> References:
> https://lore.kernel.org/dri-devel/71a9dbf4609dbba46026a31f60261830163a0b99.1701267411.git.mehdi.djait@bootlin.com/
> https://www.sharpsde.com/fileadmin/products/Displays/2016_SDE_App_Note_for_Memory_LCD_programming_V1.3.pdf
> 
> [...]

Applied to drm-misc-next, thanks!

[1/2] dt-bindings: display: Add Sharp Memory LCD bindings
      commit: 12f6baa472e097d4d55dfef9eacc36b04071bdc1
[2/2] drm/tiny: Add driver for Sharp Memory LCD
      commit: b8f9f21716fecac41d083ec8c77809ecd0b100d8

Best regards,
-- 
With best wishes
Dmitry


