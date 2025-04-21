Return-Path: <linux-pwm+bounces-5623-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF39BA950EB
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 14:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770C818942A5
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 12:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721C3264A7C;
	Mon, 21 Apr 2025 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WbbVE/pM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A9B264A7A;
	Mon, 21 Apr 2025 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745238575; cv=none; b=jWo5RdgyO1O7R/ONA2Ld/5RdLf/Ydi2681ELDib+I0dhZOpmwSHrSCujvoXGUqnIxZdHzZ5NzSq/nctjv49b/PABB86l62d67NJZInq+BGKzutUUO3e0sNnnhvPKB0xzbIkstiJTa62ycdbsVyVaavk0Lpb29XZ/ktYJFw8txkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745238575; c=relaxed/simple;
	bh=P3PXCHjzCK0zlLz+6jlqoKjvmYrLp+WlWW64KtzIqMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i67tulFBNYiHUqWFWWa2CyjKv/TKDcDRdG4iwYdPFLjEOB/WgaEEYLICB+fiHMQ+8llqgJaVzkcBJnbNT8D1joQ3ij5v2PcNO2TSwyFbNMIslAiCQK8Lq1/LbdgWwFsAFqcEfQ1Jj+BUqmZiVlyyd7+31ZvoNPcMpKSIX++4xPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=WbbVE/pM; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 779A856D;
	Mon, 21 Apr 2025 14:27:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745238444;
	bh=P3PXCHjzCK0zlLz+6jlqoKjvmYrLp+WlWW64KtzIqMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WbbVE/pMZ33ZujzD3JZ9YVUcT7SOGziV6wdBs6+ZyKuDbJJ9x6ZYaJe9bLA4GPNP6
	 YNMDR7BVQa2wtIvV3zZJslOxXTT/cWg2v/O77dfsDCzYD62grhEVETxM9IaVAlBU/9
	 z5SHHIC5kjtW2ZAr/PeTh3DqOdOSDnv1JegwQV/o=
Date: Mon, 21 Apr 2025 15:29:29 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v2 01/17] dt-bindings: mfd: adp5585: ease on the required
 properties
Message-ID: <20250421122929.GA32759@pendragon.ideasonboard.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-1-3a799c3ed812@analog.com>
 <20250421085605.GA29968@pendragon.ideasonboard.com>
 <66dd1d165df00d271491a6a5d2a8beaa25f7aec6.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66dd1d165df00d271491a6a5d2a8beaa25f7aec6.camel@gmail.com>

On Mon, Apr 21, 2025 at 01:12:33PM +0100, Nuno Sá wrote:
> On Mon, 2025-04-21 at 11:56 +0300, Laurent Pinchart wrote:
> > On Tue, Apr 15, 2025 at 03:49:17PM +0100, Nuno Sá via B4 Relay wrote:
> > > From: Nuno Sá <nuno.sa@analog.com>
> > > 
> > > It is not mandatory to use all the capabilities of the device. One can
> > > very well only use it as a gpio controller without the PWM support. This
> > > will be even more evident when support for the matrix keymap is added.
> > > Hence drop the requirements for PWM and GPIO.
> > 
> > This seems to make sense.
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > I however expected changes in this series to *not* register MFD cells
> > for the devices not enabled in DT. Could you do so in v3, on top of this
> > patch ?
> 
> Makes sense... In theory, I would go with MFD_CELL_OF() but that would need (I
> guess) bindings for all the devices and since PWM and GPIO were not introduced
> with that...

I initially designed the bindings with child nodes, but got told to
instead use a single DT node :-(

> Anyways, I'll look into some "mandatory" property for each of the supported
> cells and use that as deciding point.

Sounds good to me.

> > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > ---
> > >  Documentation/devicetree/bindings/mfd/adi,adp5585.yaml | 3 ---
> > >  1 file changed, 3 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> > > b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> > > index
> > > ee2272f754a339569c793102928ddd13249f8fee..e30e22f964f78519b2ec207e9415e4897d
> > > b5c702 100644
> > > --- a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> > > +++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> > > @@ -52,9 +52,6 @@ patternProperties:
> > >  required:
> > >    - compatible
> > >    - reg
> > > -  - gpio-controller
> > > -  - "#gpio-cells"
> > > -  - "#pwm-cells"
> > >  
> > >  allOf:
> > >    - if:

-- 
Regards,

Laurent Pinchart

