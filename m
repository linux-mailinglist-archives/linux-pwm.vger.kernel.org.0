Return-Path: <linux-pwm+bounces-2269-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084268D2680
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 22:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867DE1F22703
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 20:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2A717A936;
	Tue, 28 May 2024 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BV0Xz7UT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF1E17A924;
	Tue, 28 May 2024 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929382; cv=none; b=fFw4xbFvlSu0aqXiiTtQdNEu47DplQRSYdBTAOS3nzfmRuFCmnkdwPabYIkUFglqMWriQ0XpVTcI4XghfIP+b520QsYIo5a7WvwntLC9NhDtBO2a/U3dNRoEH1m3mHjTO0rHiEuOWikMuPYSJJqyBk0bkLoP3//K8cZsOzFfAZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929382; c=relaxed/simple;
	bh=tVjLiezldTN3tlhT1SQyWBYDQNYD3QQvsYes9mrDLzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYUWJVJdVMrOceKiZHffDohp5p8XX5tuiduBIEgtYUh2BofPJXqGtQvPs4uE3CWy2HVBLgxJGS6vadWjTJ/Sn7HnT0mlvflwf9D+I39yLU5fpJ3lEujMdmJLiqDcQgQ2Ql06topjLUnyTE/fPRm5G6xETCEEmp/gy33lJOEXD+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=BV0Xz7UT; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A2F873A2;
	Tue, 28 May 2024 22:49:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716929375;
	bh=tVjLiezldTN3tlhT1SQyWBYDQNYD3QQvsYes9mrDLzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BV0Xz7UTHgn+G+XsdphzhCRA5e5V8ysDW8H3t1XTVkLtdXW+dhMPSRmHIrWUdCIG5
	 NJcWmxV9c1E95+tarDE4+rusyCNRcJF5/hys+nPJI8keTceBNGVnodJsfVcTIIvKze
	 D3jAdeN2nen3U47dsUpVbFiQYtI01bXPH8dqmn4o=
Date: Tue, 28 May 2024 23:49:26 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pwm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: Add bindings for the Analog Devices
 ADP5585
Message-ID: <20240528204926.GE8500@pendragon.ideasonboard.com>
References: <20240528190315.3865-1-laurent.pinchart@ideasonboard.com>
 <20240528190315.3865-2-laurent.pinchart@ideasonboard.com>
 <171692890886.1957549.3597242516268327909.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <171692890886.1957549.3597242516268327909.robh@kernel.org>

On Tue, May 28, 2024 at 03:41:48PM -0500, Rob Herring (Arm) wrote:
> 
> On Tue, 28 May 2024 22:03:11 +0300, Laurent Pinchart wrote:
> > The ADP5585 is a 10/11 input/output port expander with a built in keypad
> > matrix decoder, programmable logic, reset generator, and PWM generator.
> > These bindings model the device as an MFD, and support the GPIO expander
> > and PWM functions.
> > 
> > These bindings support the GPIO and PWM functions.
> > 
> > Drop the existing adi,adp5585 and adi,adp5585-02 compatible strings from
> > trivial-devices.yaml. They have been added there by mistake as the
> > driver that was submitted at the same time used different compatible
> > strings. We can take them over safely.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > I've limited the bindings to GPIO and PWM as I lack hardware to design,
> > implement and test the rest of the features the chip supports.
> > 
> > Changes since v1:
> > 
> > - Squash "dt-bindings: trivial-devices: Drop adi,adp5585 and
> >   adi,adp5585-02" into this patch
> > - Merge child nodes into parent node
> > ---
> >  .../devicetree/bindings/mfd/adi,adp5585.yaml  | 107 ++++++++++++++++++
> >  .../devicetree/bindings/trivial-devices.yaml  |   4 -
> >  MAINTAINERS                                   |   7 ++
> >  3 files changed, 114 insertions(+), 4 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:

My bad, I messed up. Will be fixed in v3.

> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/adi,adp5585.example.dtb: mfd@34: 'gpio' is a required property
> 	from schema $id: http://devicetree.org/schemas/mfd/adi,adp5585.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/adi,adp5585.example.dtb: mfd@34: 'gpio' is a required property
> 	from schema $id: http://devicetree.org/schemas/mfd/adi,adp5585.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240528190315.3865-2-laurent.pinchart@ideasonboard.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

-- 
Regards,

Laurent Pinchart

