Return-Path: <linux-pwm+bounces-3585-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFCB99834C
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Oct 2024 12:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D99B7B2124F
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Oct 2024 10:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A47E1BE841;
	Thu, 10 Oct 2024 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+G+Bv0Q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB56A18C03D;
	Thu, 10 Oct 2024 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728555248; cv=none; b=iF+vnNkSD483pq0iR58G2Wbk11KJTY7xj9exIFIH68HFxaarbMVMc+VkF1Mz3g6OzlmWkJPd3ngN4LOmn9oghRoS8hqw03pWZTRt81INpRXxYVhQu065KIEfJLBRGSKXSTWD8XXt+N4OLAhk3tCstlpo1Bzu44OBoWLGAWOg26o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728555248; c=relaxed/simple;
	bh=0KAiACrjjJ72TxGhBqwhkMqSGcqCFRpLzWvue9NX8Ik=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAJO8Rn8EnKVfjI9GfapulVQfv4tngwY455PfC4TvsgwVJ1lVEU56keCvaccswvotWnAjOwqC4sbkccoZamKBzeKWifrRHNu2+4RVph2gC9g0z5bqZizjp/tcxBOAzDf3ndgewVx6CCC/UGTO4yzZ+mSUdPLDzhjOFtFQmmEJ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+G+Bv0Q; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43111cff9d3so5409705e9.1;
        Thu, 10 Oct 2024 03:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728555245; x=1729160045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NEBHPmIBUM6VSOI3jWXFPmWe5D+zUJl1ezE/xec47aQ=;
        b=m+G+Bv0QBFoXAJsmsy8eym2F4eSbjA5hhDVpmonX6QwBtrSlzR9ozpdba1xcIZXoZf
         ibcgut80lJSqsejGTRixgKFzMP8oCFtPXtSKpfdBlXt6l/f8Q2jWbjT8saUbxn2s0zQ/
         cflLKz9QM1snWunmfvrf/A29dpp94NaQy/WUjBON3GUF4hHjEWVMmq7rLu/bzNfn9oWV
         GgcJQKz4TgSg6g6ypQogWMAuKhypCSf3JyNt+j+ktAwc0X86MO/rRB7yGz5k4hzpnX+F
         qvYyU3Mb8ZQMPrgPncBYIY54A/0oegegL4VmyAXcNOqDSl86PII3nTAuJrpsLi97xaF0
         5lqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728555245; x=1729160045;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEBHPmIBUM6VSOI3jWXFPmWe5D+zUJl1ezE/xec47aQ=;
        b=wyb5ccH61G/59e3+QD0OX+ORaqbpfyKbyzRX9S5/wPCQTPzfuFDog0pox+ytdQlLs4
         5jE99g4OjmKkctqJOV434pfw/Opji3V+HrtfxPZt3IknrLKH20ybwrvQd8ssyZ9JJqTW
         t2e8ykx1FungljZGjRaunkBJp5QSVALInbdsCvnlVqV4dbzHUTOyZlUetmWRP7t3fotX
         yARxqINfAPTOM4j8ubJA/mpZuuDCJv01rMC3Nfyqq0WHnA80f0SdkAplODUmcSCnjwpt
         VsL8JPegIeFuFm/al8vsBz8j5meFyiyLSa30ItHszCf/farnkPSsNqUMx+wVpXTEfmHn
         JE0g==
X-Forwarded-Encrypted: i=1; AJvYcCVwLAgJKlRz6dSJQhKqcXph+K3Kz0HRqdPXWHOsTc57VGrm5qrEnYAo42uWMEqxaQ0gPHoXp9gzF86TVA==@vger.kernel.org, AJvYcCX7fM2Pm7Ah7FEb2wtZ7XyCzaXs5f8e6DzZjbuebF4iIfcCba0XHaVEXdunQzcgaOd0rc335ZhWy/5V@vger.kernel.org, AJvYcCXHSgCdpbAPoINhB0iTk9SpRgTyV705DTSa3qovX8mE9+QAf8cNDBx5ns3d2t3bG6PCrmOmMW9fec7o@vger.kernel.org
X-Gm-Message-State: AOJu0YzN2npupRjT0M86AHY0YH2BMAIZaPOMjSywSgslnSt1G1Z5WhEp
	ibXS19QSnhI3I2t5c6te5Uw4yDyClZUded4rFi+q01vKB1f9A5CI
X-Google-Smtp-Source: AGHT+IGDPGThMhthTE4710yoRanga/BmvaFtKZR6ry5ge58zkraATJT3E+r426UaY8y7XNd+9NOQAQ==
X-Received: by 2002:a05:600c:47d7:b0:431:12d0:746b with SMTP id 5b1f17b1804b1-43112d0755emr31012825e9.35.1728555244842;
        Thu, 10 Oct 2024 03:14:04 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8940sm1117058f8f.6.2024.10.10.03.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 03:14:04 -0700 (PDT)
Message-ID: <6707a8ec.df0a0220.376450.293e@mx.google.com>
X-Google-Original-Message-ID: <Zweo6cusuf9_tnnt@Ansuel-XPS.>
Date: Thu, 10 Oct 2024 12:14:01 +0200
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
Subject: Re: [PATCH v5 3/5] mfd: airoha: Add support for Airoha EN7581 MFD
References: <20241001-en7581-pinctrl-v5-0-dc1ce542b6c6@kernel.org>
 <20241001-en7581-pinctrl-v5-3-dc1ce542b6c6@kernel.org>
 <20241002132518.GD7504@google.com>
 <ZwWscWk5axQI9H1t@lore-desk>
 <20241009104821.GF276481@google.com>
 <20241009105550.GG276481@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009105550.GG276481@google.com>

On Wed, Oct 09, 2024 at 11:55:50AM +0100, Lee Jones wrote:
> On Wed, 09 Oct 2024, Lee Jones wrote:
> 
> > On Wed, 09 Oct 2024, Lorenzo Bianconi wrote:
> > 
> > > On Oct 02, Lee Jones wrote:
> > > > On Tue, 01 Oct 2024, Lorenzo Bianconi wrote:
> > > > 
> > > > > From: Christian Marangi <ansuelsmth@gmail.com>
> > > > > 
> > > > > Support for Airoha EN7581 Multi Function Device that
> > > > > expose PINCTRL functionality and PWM functionality.
> > > > 
> > > > The device is a jumble of pinctrl registers, some of which can oscillate.
> > > > 
> > > > This is *still* not an MFD.
> > > > 
> > > > If you wish to spread this functionality over 2 drivers, use syscon to
> > > > obtain the registers and simple-mfd to automatically probe the drivers.
> > > 
> > > Hi Lee,
> > > 
> > > IIUC you are suggesting two possible approaches here:
> > > 
> > > 1- have a single driver implementing both pinctrl and pwm functionalities.
> > >    This approach will not let us reuse the code for future devices that
> > >    have just one of them in common, like pwm (but we can live with that).
> > 
> > If you can have one without the other, then they are separate devices.
> > 
> > > 2- use a device node like the one below (something similar to [0])
> > > 
> > > system-controller@1fbf0200 {
> > > 	compatible = "syscon", "simple-mfd";
> > > 	reg = <0x0 0x1fbf0200 0x0 0xc0>;
> > > 
> > > 	interrupt-parent = <&gic>;
> > > 	interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> > > 
> > > 	gpio-controller;
> > > 	#gpio-cells = <2>;
> > > 
> > > 	interrupt-controller;
> > > 	#interrupt-cells = <2>;
> > > 
> > > 	pio: pinctrl {
> > > 		compatible = "airoha,en7581-pinctrl";
> > > 
> > > 		[ some pinctrl properties here ]
> > > 	};
> > > 
> > > 	#pwm-cells = <3>;
> > > 
> > > 	pwm {
> > > 		compatible = "airoha,en7581-pwm";
> > > 	};
> > > };
> > > 
> > > Please correct me if I am wrong, but using syscon/simple-mfd as compatible
> > > string for the 'parent' device, will require to introduce the compatible strings
> > > even for the child devices in order to probe them, correct? 
> > > If so, as pointed out by Christian, this is something nacked by Rob/Krzysztof/Conor
> > > (this is the main reason why we introduced a full mfd driver here).
> > > 
> > > @Rob, Krzysztof, Conor: am I right?
> > 
> > I don't see why separate functionality shouldn't have separate
> > compatible strings, even if the registers are together.  Register layout
> > and functionality separation are not related.
> 
> We've been happy to support both pinctrl and pwm devices before:
> 
>   git grep "\-pinctrl\|\-pwm" -- drivers/mfd
>   git grep "\-pinctrl\|\-pwm" -- arch/*/boot/dts
> 
>   git grep "\-pinctrl" -- arch/*/boot/dts | wc -l
>   602
>   git grep "\-pwm" -- arch/*/boot/dts | wc -l
>   856
> 
> What makes this particular device different to all of the others?
>

Hi Lee,

this would be the final DTS following the "simple-mfd" pattern.

Can you confirm it's correct?

mfd: system-controller@1fbf0200 {
	compatible = "syscon", "simple-mfd";
	reg = <0x0 0x1fbf0200 0x0 0xc0>;
 
	interrupt-parent = <&gic>;
	interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 
	gpio-controller;
	#gpio-cells = <2>;
 
	interrupt-controller;
	#interrupt-cells = <2>;

	gpio-ranges = <&mfd 0 13 47>;

	#pwm-cells = <3>;
 
	pio: pinctrl {
		compatible = "airoha,en7581-pinctrl";
 
		mdio_pins: mdio-pins {
			mux {
				function = "mdio";
				groups = "mdio";
			};
 
			conf {
				pins = "gpio2";
				output-high;
			};
		};
 
		pcie0_rst_pins: pcie0-rst-pins {
			conf {
				pins = "pcie_reset0";
				drive-open-drain = <1>;
			};
		};
 
		pcie1_rst_pins: pcie1-rst-pins {
			conf {
				pins = "pcie_reset1";
				drive-open-drain = <1>;
			};
		};
	};
 
	pwm {
		compatible = "airoha,en7581-pwm";
	};
};

-- 
	Ansuel

