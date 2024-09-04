Return-Path: <linux-pwm+bounces-3088-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E4B96B9A1
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Sep 2024 13:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D0E1F27469
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Sep 2024 11:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E051D0165;
	Wed,  4 Sep 2024 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtBj4Xf0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE6F1CF7C1;
	Wed,  4 Sep 2024 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448014; cv=none; b=I+cPupOZpODKqI/OBYwOnlRKtq0In9DzLslWIMdk4DCuK+IiPfG5bfoekyeb6VMYKGrPbcnE3TO+Sfbn12BT4o6+zqVtsvI3uK5ni+MRj3Mr2SgcfUTsnvzAsiEWUH58RQdV+Pj22YJvUQogZ9x1OQOp5srS4DN2Zmc0V5IZgaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448014; c=relaxed/simple;
	bh=QJyCSN3feG+byyzZGQhSYGSDrqviz8wfeSER5fcV6Ro=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1yGMIHWLssVPUaBQheEqUTaeWVtuA0BWDW5UGBSl3YL2Ql/YJNRe65OcwsMRXs+aRT9grStcmBGbZV3tD9+Hb3fZMxeVUg9DnNw5RmiMocc4I3BDkR6og6ANy6wxTWyZbU84hKJZycEIq2BnJpyh5MVxBu6naFRHST97olFxeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtBj4Xf0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42bb8cf8a5bso5624915e9.2;
        Wed, 04 Sep 2024 04:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725448011; x=1726052811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xko3AdnDwXu1UPoPnl6WxfrRj7WMJuxp0Ni5HvaBX0o=;
        b=LtBj4Xf0nwoHB0grlirbFyTlFFY5q6TS37javWMw34x3vXamVF4EVD05fOacfIJFFT
         aZnR3NnTV6VpGfh1wnVZS4IMi3RnzCzgQwBsxnrre6gtuCSdjilVKV6Nd4vc5RjP3MZu
         AbOf+vIE0m+VjNQFZMIhVoVmX5vVtDOyu9jnv7zC+9pfJr6psUud1OvZJCtart4CoLxU
         gpaAJgT9ctUrb+OwgpPjQbsBjfOXnhmrHhGvhUT7THRTIpvXaEcoBzvSpxs5+HTH5XnZ
         e0Q7VogjMLDHHicuE/OjLSF5FuGXUx9zLAwZzFY/pPHrt4VfAMERYfoLZWZURXWYuu9e
         QvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725448011; x=1726052811;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xko3AdnDwXu1UPoPnl6WxfrRj7WMJuxp0Ni5HvaBX0o=;
        b=bn3TesguCw7NNDyoawF5FYIxAZgItTjN1r28TnhDICaKHdXlatBnONsXPWrJzYDeuX
         KWdwVwLv3x2raQ00ovSxfaHZoOoW4D8g7svtgaYWe4yaqFy/LiFSJFBEVQTm0otvkGcx
         lqYWeLaI4Fo7FVCfg3uJOqJsIx76P2Fa7kJWOQy5yqRVQJ3yrMO9NFTD/HYxjKYFVG5R
         CMP3IN0QHK6Dlf8rahNsiNc4UL3IFolhPZ43/8uCv97k/68BXg44qFJV7BzLzLcc6u3B
         OKIUTT2XGLWFbpQwGHa2NlMzdZbgFQH9MLH0ZRZ67h160AuYgB4iqDanYAUOFlreTI45
         HTfg==
X-Forwarded-Encrypted: i=1; AJvYcCUOK0aQiYesDb9tKIgi0Y9NeC3ghS5r/IeZ52lbSTH2EGF9HSuGcaF8d00r22rg3EuaKKLUr+ZSZ0uZ@vger.kernel.org, AJvYcCVO4T0gfN9eK370gYhWjPSnXFsTks6jQj/mKXwMys5+tvt8Fh34fvMPLBcH1ltlifGCzh1CT58GXLFc@vger.kernel.org, AJvYcCVOrsysmZlh1PQ87r8qbvbu0uB2XPvtsSGhjRvXT9t0ENbWK0b8aKqQRXE8ffRmj7XTpNE/E7U6MCwa4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXIRzTCoP/7ECyoNlwMYvxxMBu9b48jmuYWjm0SxobqNDV55g+
	wCQXAov3/l/8WS5FdmW6O8bB7XZWbobT1gU8z1xIbq/hDZvytxT9
X-Google-Smtp-Source: AGHT+IHUMikIomgVAajePk5PmkHaQSWCkSEU4DQdow9b2O+jbzsNIiZOILgd/MoiMo4W1w4+DjhFag==
X-Received: by 2002:a05:600c:4e8c:b0:428:2e9:65a9 with SMTP id 5b1f17b1804b1-42c9548d081mr14423945e9.28.1725448010702;
        Wed, 04 Sep 2024 04:06:50 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-16-250-236.retail.telecomitalia.it. [87.16.250.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bbf00e095sm161231175e9.13.2024.09.04.04.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 04:06:50 -0700 (PDT)
Message-ID: <66d83f49.050a0220.3d273e.b096@mx.google.com>
X-Google-Original-Message-ID: <Ztg_RsH5rep8cwuN@Ansuel-XPS.>
Date: Wed, 4 Sep 2024 13:06:46 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, benjamin.larsson@genexis.eu,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 2/5] dt-bindings: mfd: Add support for Airoha EN7581
 GPIO System Controller
References: <20240831-en7581-pinctrl-v3-0-98eebfb4da66@kernel.org>
 <20240831-en7581-pinctrl-v3-2-98eebfb4da66@kernel.org>
 <20240903153353.GZ6858@google.com>
 <66d72ea9.df0a0220.21f5f.029f@mx.google.com>
 <20240903164218.GC6858@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903164218.GC6858@google.com>

On Tue, Sep 03, 2024 at 05:42:18PM +0100, Lee Jones wrote:
> On Tue, 03 Sep 2024, Christian Marangi wrote:
> 
> > On Tue, Sep 03, 2024 at 04:33:53PM +0100, Lee Jones wrote:
> > > On Sat, 31 Aug 2024, Lorenzo Bianconi wrote:
> > > 
> > > > From: Christian Marangi <ansuelsmth@gmail.com>
> > > > 
> > > > Add support for Airoha EN7581 GPIO System Controller which provide a
> > > > register map for controlling the GPIO, pinctrl and PWM of the SoC.
> > > > 
> > > > Schema define cells for both gpio/interrupt controller and PWM.
> > > > Moreover it provides a dedicated pinctrl node for pins and config
> > > > definitions.
> > > > 
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > >  .../bindings/mfd/airoha,en7581-gpio-sysctl.yaml    | 433 +++++++++++++++++++++
> > > >  1 file changed, 433 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/mfd/airoha,en7581-gpio-sysctl.yaml b/Documentation/devicetree/bindings/mfd/airoha,en7581-gpio-sysctl.yaml
> > > > new file mode 100644
> > > > index 000000000000..a9080c7f50f9
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/mfd/airoha,en7581-gpio-sysctl.yaml
> > > > @@ -0,0 +1,433 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/mfd/airoha,en7581-gpio-sysctl.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Airoha EN7581 GPIO System Controller
> > > > +
> > > > +maintainers:
> > > > +  - Christian Marangi <ansuelsmth@gmail.com>
> > > > +  - Lorenzo Bianconi <lorenzo@kernel.org>
> > > > +
> > > > +description:
> > > > +  Airoha EN7581 SoC GPIO system controller which provided a register map
> > > > +  for controlling the GPIO, pins and PWM of the SoC.
> > > 
> > > This whole thing is just about pins.
> > > 
> > > The MFD portion of this submission doesn't do anything.
> > >
> > 
> > Hi Lee,
> > 
> > thanks for the review. I think you missed the other series as it was
> > requested to use MFD implementation due to shared register map.
> > 
> > > Please rework this to omit the MFD driver.
> > 
> > I'm a bit confused by this you mean in the schema? Putting PWM property
> > in a pinctrl schema looks wrong to me :(
> > 
> > > 
> > > After just a glance, it looks like simple-mfd _might_ work.
> > 
> > Simple-mfd works if register map are well defined and you can have
> > something like
> > - parent define the whole register
> > - child can user reg property to register offset and subsection of the
> >   parent register
> > 
> > Here it's all mixed and scrambled and also it was requested to have a
> > very simple node that include both pwm and pinctrl property (cause that
> > is how the HW register block is designed and schema must reflect HW)
> > 
> > Hope you can understand these reasons.
> 
> Thinking very quickly before I have to rush off.
> 
> Have you considered syscon?
>

Yes it was considered and proposed but it's not suitable for what it was
suggested from DT guy. A syscon implementation would require adding
child nodes with compatible (to probe driver that way) and that got
rejected.

The main reason is that it's wrong to create .yaml that describe how
the driver structure works (mfd + child nodes with compatible) instead
of describing how the actual HW works (single register map that expose
both GPIO/PINCTRL and PWM)

-- 
	Ansuel

