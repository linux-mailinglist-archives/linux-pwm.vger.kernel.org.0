Return-Path: <linux-pwm+bounces-5435-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A00A83BE2
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Apr 2025 09:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03F48C5196
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Apr 2025 07:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7811E1DF9;
	Thu, 10 Apr 2025 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otmoFr3v"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49849130A54;
	Thu, 10 Apr 2025 07:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744271713; cv=none; b=dzSRBtKX/I1E7LDrGzAZga0wktPkNhKihu71To84Q2CH06AvdexGdv05B46huO0VSf5+wdBIrTfC9tmd1Fx0mj03XHLByhALN/MGiU7GWVdUvKxDPkhbUotaiSGcuyUeaR8PtUZ03r2mFclQn3mxEPbbfB9gqED+KALXMOXUahw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744271713; c=relaxed/simple;
	bh=lnFZPq6GIT4yu3NTRkld+9fjjb3E4qY9+RFd4qgcgxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSBy95p5Wgb14cB3RolAgc1uw7lKfQ69Sngh2W5/NDYQ1AeB10vxoZQCS+dMuGh+ZqdO7tQLKufi2EvyP41N7Sm/hWN0RCqLGiuKKmKj0eMNdtZDphgsfssbGDMtaQE7OQPMOTiRbSlimu6gPjat5yp10BQcO/Z0XgHR4swIqVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otmoFr3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827EBC4CEDD;
	Thu, 10 Apr 2025 07:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744271712;
	bh=lnFZPq6GIT4yu3NTRkld+9fjjb3E4qY9+RFd4qgcgxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=otmoFr3vxowmlBDmjkGrpqwB37cb7dxQ+cnFzN3C9WSdIFqHe7hblzY0aaz/3Bzmv
	 8Is4qyffPO+HY1ZeyFn+44YNhlrRcY9HhdQ4UzCUqYi8dRXdBuPqB43j+yUU4kiWnG
	 mtKxRh9nd7eA/ABKMBKXsUNY4ik67mC8yPje7XS6hgJQTc3cW1DUkSZfV2gali/JQt
	 HkBLtDeZQaqDQL5dHGrd8JQhtE1ATi8RAmGXf1ha1QHgdiPSQ+X53Pynwxi2T93rUz
	 /nfIE2FOA/zNCWGmO8htFkORRVaBN0mM5v7xoJRaHnoXCCIaoLXtGx7gn0qc/+L/we
	 4Mv0YLRPSLC3w==
Date: Thu, 10 Apr 2025 08:55:05 +0100
From: Lee Jones <lee@kernel.org>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	andriy.shevchenko@intel.com,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [External] : [PATCH v6 01/12] dt-bindings: mfd: gpio: Add MAX7360
Message-ID: <20250410075505.GM372032@google.com>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-1-7a2535876e39@bootlin.com>
 <a9d8ca30-3836-49b3-898c-c351b2c44a76@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9d8ca30-3836-49b3-898c-c351b2c44a76@oracle.com>

On Wed, 09 Apr 2025, ALOK TIWARI wrote:

> 
> 
> On 09-04-2025 20:25, Mathieu Dubois-Briand wrote:
> > Add device tree bindings for Maxim Integrated MAX7360 device with
> > support for keypad, rotary, gpios and pwm functionalities.
> > 
> > Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> > ---
> >   .../bindings/gpio/maxim,max7360-gpio.yaml          |  83 ++++++++++
> >   .../devicetree/bindings/mfd/maxim,max7360.yaml     | 171 +++++++++++++++++++++
> >   2 files changed, 254 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml b/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
> > new file mode 100644
> > index 000000000000..21d603d9504c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
> > @@ -0,0 +1,83 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: https://urldefense.com/v3/__http://devicetree.org/schemas/gpio/maxim,max7360-gpio.yaml*__;Iw!!ACWV5N9M2RV99hQ!LySDuQZdU3DANTEmkRlntMCbFm69zp24O0wAwuujlnN1Zh9-xPEHZu7fj5d_O7vIxUHn9b6gqg9MHtd9ntPvXQvakCad_v0$
> > +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!ACWV5N9M2RV99hQ!LySDuQZdU3DANTEmkRlntMCbFm69zp24O0wAwuujlnN1Zh9-xPEHZu7fj5d_O7vIxUHn9b6gqg9MHtd9ntPvXQvacsB3d9k$
> > +
> > +title: Maxim MAX7360 GPIO controller
> > +
> > +maintainers:
> > +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
> > +  - Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> > +
> > +description: |
> > +  Maxim MAX7360 GPIO controller, in MAX7360 chipset
> > +  https://urldefense.com/v3/__https://www.analog.com/en/products/max7360.html__;!!ACWV5N9M2RV99hQ!LySDuQZdU3DANTEmkRlntMCbFm69zp24O0wAwuujlnN1Zh9-xPEHZu7fj5d_O7vIxUHn9b6gqg9MHtd9ntPvXQvavZnHZJk$
> > +
> > +  The device provide two series of GPIOs, referred here as GPIOs and GPOs.
> typo: The device provides two series of GPIOs,
> > +
> > +  PORT0 to PORT7 pins can be used as GPIOs, with support for interrupts and
> > +  constant-current mode. These pins will also be used by the torary encoder and
> typo: ie rotary encoder ?
> > +  PWM functionalities.
> > +
> > +  COL2 to COL7 pins can be used as GPOs, there is no input capability. COL pins
> > +  will be partitionned, with the first pins being affected to the keypad
> > +  functionality and the last ones as GPOs.
> > +
> typo: partitionned -> partitioned

Please trim your responses.

You comments should have blank lines above below your comments too please.

-- 
Lee Jones [李琼斯]

