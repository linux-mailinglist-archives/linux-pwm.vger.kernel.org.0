Return-Path: <linux-pwm+bounces-3586-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F3F998409
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Oct 2024 12:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F79C1F278E1
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Oct 2024 10:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792701C1757;
	Thu, 10 Oct 2024 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnP+7Ut6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787F81C1AB3;
	Thu, 10 Oct 2024 10:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556911; cv=none; b=Dz98qDXMafYfXDyVvhJBBesBEjLqaHkfuRc9JrZ4Ff9pIyEqXmwRaVH3qNVBTtG8CPlxRmMANTjYd5GDv39KEuXgkcc053Q/K6hKb2cVmYt4I+FyVZZKrpLGgwpmhZG8bttn85hYsfJJ8ktSuIsxYvc1WK+3VB+NhGWFFAKOTVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556911; c=relaxed/simple;
	bh=36igFE6ds31Mh4PJf0bvgQdaJ0lnLaEOp7UNETeWus0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qU1xpClXdNJI2QpPo/CCywWNpN+DiK6WsUSmfboZ9lCcoAfH8hMTp2pmK9G60WfHQk5QGtD+i6iwrQNTiJvYc9OQ99V4el12cJGsmjZNz5deQA5veLc4gTjFTR2ApPEhV5mCyVinWMyI8aFJRVkD3OwuFSarV0S+ZcOuzgw9p5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnP+7Ut6; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d325beee2so418484f8f.2;
        Thu, 10 Oct 2024 03:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728556908; x=1729161708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ICu3VsZKvL2eXNq4nP6eMLyiBCYNXniiqJTCYSiqQoM=;
        b=nnP+7Ut6T5n2sTqOmJ3WsbYmqe3kZbioEAqPbi19e7EXCyDdLpZ7Ge2vXJfsLJdM1d
         0aYHWf/ZNFAL1bX+FWuWmt9Fl3XF5z9hMxTpp9e5kjGfDxkIguh/dxfaQrTf92JRsJNi
         5T76XsC4gzLwDtLpTM7TPs462pqpZ86ns7KXKqX9zS24bOrCGI/Uix98IT6w0MyYyZbe
         26QkCKyvC6zus7FC3KXm+tbtRCDSRtzkyNZvGWG3vGZHLCBahsiPGQW3rD0NfhlOdT3I
         M0CmRI+9EkHK6mxcdOUyugWO26Dw4lvKN+PVxCr/HYgWqHSsFIxANDW38rHcMSvEYYFP
         MGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728556908; x=1729161708;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICu3VsZKvL2eXNq4nP6eMLyiBCYNXniiqJTCYSiqQoM=;
        b=fbKMGg3xNd9WUcRk4B3Xu4PLime/WBRLjXY5znH4KLwqibtVgGG1T1D0lGLs0dR8Dv
         nafU2Y0PHgWWlTeP5mSJkN291ay6t+LfewCF47w7+mlMdQMwMQ2/bDrAqwIGMYTkzW0y
         K+O6M49XWowGz+EeyG73qnDR0s7qxUo/7xiXAp6M4VDqX4BXnqhpIwoF6MdW7nu+mkB/
         d9k6PDJwxCnfOpa4UHY3nkjPf65XgqoBIc9aUY7KW6ED+KVZr7F8SsA3bAwvvs5XwEHv
         fJK01CrfvheBp24hbhenxFklpE9dHDIpUmMa+LhVCBeitU+Upma5dZ2KSdhObmSdLPV8
         sYrw==
X-Forwarded-Encrypted: i=1; AJvYcCU32pSk5CjMksm60W0r8gw7uFoz/4Zn+akopNA4YjatwKuw7R4ViwrKA2sM0Qn312B/aJ8s9f1fnP2w@vger.kernel.org, AJvYcCV3CSJTTQeLX7zKyKXPx1/Ctby3fQW0CDBx5d3xtEvNFEXvbK20j6h0+fDQ5Ff5nrKHHfgNrcCVzuT0@vger.kernel.org, AJvYcCXbCrUqnQiTOVhJqpiCueoSqIHHNiKOp2pnQb7TmNiOhcACoQ/NtfSE1dw/PVCyKCi8Y4JwwmGCY+LBPg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxerh/TrP6mPFdi0PlMbOHCCspLuD9G877AXknukxbyQYXBj4E3
	PPw/yGe3CACBGOdIsb5n8kJ5+6nJpxemUfo/CSahb5WsHHDvMmU0KzDkNQ==
X-Google-Smtp-Source: AGHT+IEcIdI8ebXVd8j3aFJ8Y9FMkMiCv44M+O5iKAgT+bUxjjTjVdQBz77Q5o/nX3gB7U6b/V4r4g==
X-Received: by 2002:a5d:4bd0:0:b0:364:6c08:b9b2 with SMTP id ffacd0b85a97d-37d3ab004aemr3042815f8f.45.1728556907439;
        Thu, 10 Oct 2024 03:41:47 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79f679sm1181969f8f.73.2024.10.10.03.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 03:41:47 -0700 (PDT)
Message-ID: <6707af6b.df0a0220.cf486.2f75@mx.google.com>
X-Google-Original-Message-ID: <ZwevaOHK9FAtyzyg@Ansuel-XPS.>
Date: Thu, 10 Oct 2024 12:41:44 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, benjamin.larsson@genexis.eu,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 3/5] mfd: airoha: Add support for Airoha EN7581 MFD
References: <20241001-en7581-pinctrl-v5-0-dc1ce542b6c6@kernel.org>
 <20241001-en7581-pinctrl-v5-3-dc1ce542b6c6@kernel.org>
 <20241002132518.GD7504@google.com>
 <ZwWscWk5axQI9H1t@lore-desk>
 <20241009104821.GF276481@google.com>
 <20241009105550.GG276481@google.com>
 <6707a8ec.df0a0220.376450.293e@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6707a8ec.df0a0220.376450.293e@mx.google.com>

On Thu, Oct 10, 2024 at 12:14:01PM +0200, Christian Marangi wrote:
> On Wed, Oct 09, 2024 at 11:55:50AM +0100, Lee Jones wrote:
> > On Wed, 09 Oct 2024, Lee Jones wrote:
> > 
> > > On Wed, 09 Oct 2024, Lorenzo Bianconi wrote:
> > > 
> > > > On Oct 02, Lee Jones wrote:
> > > > > On Tue, 01 Oct 2024, Lorenzo Bianconi wrote:
> > > > > 
> > > > > > From: Christian Marangi <ansuelsmth@gmail.com>
> > > > > > 
> > > > > > Support for Airoha EN7581 Multi Function Device that
> > > > > > expose PINCTRL functionality and PWM functionality.
> > > > > 
> > > > > The device is a jumble of pinctrl registers, some of which can oscillate.
> > > > > 
> > > > > This is *still* not an MFD.
> > > > > 
> > > > > If you wish to spread this functionality over 2 drivers, use syscon to
> > > > > obtain the registers and simple-mfd to automatically probe the drivers.
> > > > 
> > > > Hi Lee,
> > > > 
> > > > IIUC you are suggesting two possible approaches here:
> > > > 
> > > > 1- have a single driver implementing both pinctrl and pwm functionalities.
> > > >    This approach will not let us reuse the code for future devices that
> > > >    have just one of them in common, like pwm (but we can live with that).
> > > 
> > > If you can have one without the other, then they are separate devices.
> > > 
> > > > 2- use a device node like the one below (something similar to [0])
> > > > 
> > > > system-controller@1fbf0200 {
> > > > 	compatible = "syscon", "simple-mfd";
> > > > 	reg = <0x0 0x1fbf0200 0x0 0xc0>;
> > > > 
> > > > 	interrupt-parent = <&gic>;
> > > > 	interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> > > > 
> > > > 	gpio-controller;
> > > > 	#gpio-cells = <2>;
> > > > 
> > > > 	interrupt-controller;
> > > > 	#interrupt-cells = <2>;
> > > > 
> > > > 	pio: pinctrl {
> > > > 		compatible = "airoha,en7581-pinctrl";
> > > > 
> > > > 		[ some pinctrl properties here ]
> > > > 	};
> > > > 
> > > > 	#pwm-cells = <3>;
> > > > 
> > > > 	pwm {
> > > > 		compatible = "airoha,en7581-pwm";
> > > > 	};
> > > > };
> > > > 
> > > > Please correct me if I am wrong, but using syscon/simple-mfd as compatible
> > > > string for the 'parent' device, will require to introduce the compatible strings
> > > > even for the child devices in order to probe them, correct? 
> > > > If so, as pointed out by Christian, this is something nacked by Rob/Krzysztof/Conor
> > > > (this is the main reason why we introduced a full mfd driver here).
> > > > 
> > > > @Rob, Krzysztof, Conor: am I right?
> > > 
> > > I don't see why separate functionality shouldn't have separate
> > > compatible strings, even if the registers are together.  Register layout
> > > and functionality separation are not related.
> > 
> > We've been happy to support both pinctrl and pwm devices before:
> > 
> >   git grep "\-pinctrl\|\-pwm" -- drivers/mfd
> >   git grep "\-pinctrl\|\-pwm" -- arch/*/boot/dts
> > 
> >   git grep "\-pinctrl" -- arch/*/boot/dts | wc -l
> >   602
> >   git grep "\-pwm" -- arch/*/boot/dts | wc -l
> >   856
> > 
> > What makes this particular device different to all of the others?
> >
> 
> Hi Lee,
> 
> this would be the final DTS following the "simple-mfd" pattern.
> 
> Can you confirm it's correct?
> 
> mfd: system-controller@1fbf0200 {
> 	compatible = "syscon", "simple-mfd";
> 	reg = <0x0 0x1fbf0200 0x0 0xc0>;
>  
> 	interrupt-parent = <&gic>;
> 	interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>  
> 	gpio-controller;
> 	#gpio-cells = <2>;
>  
> 	interrupt-controller;
> 	#interrupt-cells = <2>;
> 
> 	gpio-ranges = <&mfd 0 13 47>;
> 
> 	#pwm-cells = <3>;
>  
> 	pio: pinctrl {
> 		compatible = "airoha,en7581-pinctrl";
>  
> 		mdio_pins: mdio-pins {
> 			mux {
> 				function = "mdio";
> 				groups = "mdio";
> 			};
>  
> 			conf {
> 				pins = "gpio2";
> 				output-high;
> 			};
> 		};
>  
> 		pcie0_rst_pins: pcie0-rst-pins {
> 			conf {
> 				pins = "pcie_reset0";
> 				drive-open-drain = <1>;
> 			};
> 		};
>  
> 		pcie1_rst_pins: pcie1-rst-pins {
> 			conf {
> 				pins = "pcie_reset1";
> 				drive-open-drain = <1>;
> 			};
> 		};
> 	};
>  
> 	pwm {
> 		compatible = "airoha,en7581-pwm";
> 	};
> };
>

Also asking to Rob, Krzysztof and Conor.

Is this DTS OK for you?

-- 
	Ansuel

