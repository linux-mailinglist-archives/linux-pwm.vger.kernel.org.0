Return-Path: <linux-pwm+bounces-4654-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4025FA150A8
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 14:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A2497A2689
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 13:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBF220011A;
	Fri, 17 Jan 2025 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLJOzCZW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BFC1FFC55;
	Fri, 17 Jan 2025 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737121136; cv=none; b=cQl7HI2IvCNY5cj4lQ3bLMF1896+XNr7zlpAOZHS/dGhXB2ZLtLR7xER0gI0cnxxy8foghQBOIPyVc4KhJgqhvnJodIfeVIVQlCuUubog4SkEtLd0IRNmwYNDC8NOP3i8hxsfOQnCqZOReYOreiogjJxJyrLnp+HnmnCAN5GvDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737121136; c=relaxed/simple;
	bh=amqRnUq2L/EXSocQI4TBHewoyWIDai3355YmI2WHaIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0PmcmRzlzAu0pCcsI/IEzFg9AiYhbBsGeiBN4Ys/TAbLbyP1ThWidUWUuL4bCSd4tH8GO21qbW5ZSR5EfeUEhMM6Ow4FLGR34kANSAuL0pEtY6fBiMr7h1XRykUPox4NSdvlMP9EWbpsivebCaxTCnRPIRhvQmUGoGCOIyWr5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLJOzCZW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987F9C4CEDD;
	Fri, 17 Jan 2025 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737121135;
	bh=amqRnUq2L/EXSocQI4TBHewoyWIDai3355YmI2WHaIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kLJOzCZWZeek4eWmUHbub8k0heFZemdZwkFSwRJLRTfCjeKkpRQDr//hFk1QYYPNo
	 V07wrL5MGMWklOJg+TjiarBA3H4V2VguBal4iXPiNLTWQrOkz1GaAUS4EjkPT2v4tl
	 FZnHJfWQMbgABVowJHPbDXZ118rZM0ys0/6PseuRBBhIAEGxxy3yp+4KZOx7REwLqG
	 jcaoBHX3ykJQjeVPHzevtLFNKB/95IO4JCcnOpHtS6+zFJ+1eM6qX/jGLspPXKLjXK
	 0b8Nr1KtW1bFaWsxS8l3+CmKduQJH2puRXlj23ExX6CeZmqgZyYtwDS5BHsaTaz+rH
	 xCrkMT+sTEc+w==
Date: Fri, 17 Jan 2025 07:38:54 -0600
From: Rob Herring <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Saravana Kannan <saravanak@google.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/1] pwm: Add support for pwm nexus dt bindings
Message-ID: <20250117133854.GA500748-robh@kernel.org>
References: <20250108161853.431915-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108161853.431915-1-herve.codina@bootlin.com>

On Wed, Jan 08, 2025 at 05:18:53PM +0100, Herve Codina wrote:
> Platforms can have a standardized connector/expansion slot that exposes
> signals like PWMs to expansion boards in an SoC agnostic way.
> 
> The support for nexus node [1] has been added to handle those cases in
> commit bd6f2fd5a1d5 ("of: Support parsing phandle argument lists through
> a nexus node"). This commit introduced of_parse_phandle_with_args_map()
> to handle nexus nodes in a generic way and the gpio subsystem adopted
> the support in commit c11e6f0f04db ("gpio: Support gpio nexus dt
> bindings").
> 
> A nexus node allows to remap a phandle list in a consumer node through a
> connector node in a generic way. With this remapping supported, the
> consumer node needs to knwow only about the nexus node. Resources behind
> the nexus node are decoupled by the nexus node itself.
> 
> This is particularly useful when this consumer is described in a
> device-tree overlay. Indeed, to have the exact same overlay reused with
> several base systems the overlay needs to known only about the connector
> is going to be applied to without any knowledge of the SoC (or the
> component providing the resource) available in the system.
> 
> As an example, suppose 3 PWMs connected to a connector. The connector
> PWM 0 and 2 comes from the PWM 1 and 3 of the pwm-controller1. The
> connector PWM 1 comes from the PWM 4 of the pwm-controller2. An
> expansion device is connected to the connector and uses the connector
> PMW 1.
> 
> Nexus node support in PWM allows the following description:
> 	soc {
> 		soc_pwm1: pwm-controller1 {
> 			#pwm-cells = <3>;
> 		};
> 
> 		soc_pwm2: pwm-controller2 {
> 			#pwm-cells = <3>;
> 		};
> 	};
> 
> 	connector: connector {
> 		#pwm-cells = <3>;
> 		pwm-map = <0 0 0 &soc_pwm1 1 0 0>,
> 			  <1 0 0 &soc_pwm2 4 0 0>,
> 			  <2 0 0 &soc_pwm1 3 0 0>,
> 		pwm-map-mask = <0xffffffff 0x0 0x0>;
> 		pwm-map-pass-thru = <0x0 0xffffffff 0xffffffff>
> 	};
> 
> 	expansion_device {
> 		pwms = <&connector 1 57000 0>;
> 	};
> 
> From the expansion device point of view, the PWM requested is the PWM 1
> available at the connector regardless of the exact PWM wired to this
> connector PWM 1. Thanks to nexus node remapping described at connector
> node, this PWM is the PWM 4 of the pwm-controller2.
> 
> The nexus node remapping handling consists in handling #*-cells, *-map,
> *-map-mask and *-map-pass-thru properties. This is already supported
> by of_parse_phandle_with_args_map().

You need a schema for all these properties (pwm-map, etc.). A wildcard 
doesn't work because '-map$' is not unique:

$ dt-extract-props Documentation/devicetree/bindings/ | grep '\-map'
 'adi,pdm-clk-map': ['uint32-array'],
 'arm,v2m-memory-map': ['string'],
 'brcm,ccode-map': ['string-array'],
 'brcm,ccode-map-trivial': ['flag'],
 'brcm,int-map-mask': ['uint32-array'],
 'charge-current-limit-mapping': ['uint32-matrix'],
 'dai-tdm-slot-width-map': ['uint32-matrix'],
 'data-mapping': ['string-array'],
 'fsl,asrc-clk-map': ['uint32'],
 'gpio-fan,speed-map': ['uint32-matrix'],
 'gpio-map': ['uint32-matrix'],
 'gpio-map-mask': ['uint32-array'],
 'gpio-map-pass-thru': ['uint32-array'],
 'intel,vm-map': ['uint8-array'],
 'interrupt-map': ['uint32-matrix'],
 'interrupt-map-mask': ['uint32-array'],
 'iommu-map': ['uint32-matrix'],
 'iommu-map-mask': ['uint32'],
 'linux,rc-map-name': ['string'],
 'msi-map': ['uint32-matrix'],
 'msi-map-mask': ['uint32'],
 'mstar,irqs-map-range': ['uint32-matrix'],
 'no-map': ['flag'],
 'port-mapping-mode': ['flag'],
 'qcom,mpm-pin-map': ['uint32-matrix'],
 'qcom,port-mapping': ['uint32-array'],
 'qcom,rx-port-mapping': ['uint32-array'],
 'qcom,tx-port-mapping': ['uint32-array'],
 'rockchip,path-map': ['uint32-array'],
 'ti,linear-mapping-mode': ['flag'],

Rob

