Return-Path: <linux-pwm+bounces-3729-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9D59A4E55
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Oct 2024 15:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF1DB22214
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Oct 2024 13:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDCC29CEC;
	Sat, 19 Oct 2024 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWWOMvV9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4407462;
	Sat, 19 Oct 2024 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729345329; cv=none; b=t6NSb9H39avExOCpBz+tq6uy9lgmLMzKCmzwx//RmWRTc3olCnMJojSEIu9ySwS5eQ6LzJt8y0LOT/sccRORX0IUALoI1NkHAZBZleTvyXXwAXM8nDrueTKaLKVZ68fIRCkFyTkzANwpmmC+H8lAAdb8WeMSDLWiKv/+rDlmoUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729345329; c=relaxed/simple;
	bh=M1qJgMas5VSngnyEihdlgKK/FSQHc9ultfWTJgDRwq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aksGNwMQrtcqJNIrDVKPMiOo1pIsa1Pifr8zk3lqomoZJdwV51wrYxWvGQbb4EJ3JSHOn0y/HfiGsqYm2GkxOFqtpxS4m1n4sLCtuXnxc3sY2Z7WlKuSmKPsHIusXuVlLBgDxs5IpV7d2ax9VtRnPBE72bzMEjAMD30kdHpVsfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWWOMvV9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D9AC4CEC5;
	Sat, 19 Oct 2024 13:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729345328;
	bh=M1qJgMas5VSngnyEihdlgKK/FSQHc9ultfWTJgDRwq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cWWOMvV98sPcUFt9DS0QqOV2j6Roy+IS7XdBJt8CZgbRJlomHS3BhmMFv4zKBkn8m
	 Dd7ZXTN3T4g1/aACpDN4X83uVRoFTVgmdtVt+/WCfGGSIp5paXXgXjLD7G7ouKm30g
	 VkoN8qijRj1NfaHvIwPwnULbUf3bJMA8EPhX4GxJ3CQ2WLRgxmncs+7crRFGFSPuON
	 OumcG3d+1FiPnR2pxdgF7kTlviKzyPuV3kYN/DD8J5oq0yYH9JlUJdjw26ZQMNTNV3
	 dmNBnodX0SaDMREKVz9+F2Nr9ncBD1m34drUwN9wMhdrbAxeSN+7i592mc2iFot+Pt
	 71/Ju5+hot2ow==
Date: Sat, 19 Oct 2024 14:42:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <krzk+dt@kernel.org>, <nuno.sa@analog.com>,
 <conor+dt@kernel.org>, <ukleinek@kernel.org>, <dragos.bogdan@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>, Conor Dooley
 <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 5/6] dt-bindings: iio: adc: add ad4851
Message-ID: <20241019144201.7f274e09@jic23-huawei>
In-Reply-To: <20241018104210.51659-5-antoniu.miclaus@analog.com>
References: <20241018104210.51659-1-antoniu.miclaus@analog.com>
	<20241018104210.51659-5-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 13:42:09 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add devicetree bindings for ad485x family.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

One question inline.
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0{
> +            compatible = "adi,ad4858";
> +            reg = <0>;
> +            spi-max-frequency = <10000000>;
> +            vcc-supply = <&vcc>;
> +            vdd-supply = <&vdd>;
> +            vee-supply = <&vee>;
> +            vddh-supply = <&vddh>;
> +            vddl-supply = <&vddh>;
I was curious what these supplies are giving h and l naming.
Seems vddh is the supply for an LDO and vddhl is a way of supplying
an alternative 1.8V to the output from that LDO.

Superficially it looks like an either or situation.  I'm not that
worried if the binding enforces that detail though it would be nice
to do so.  However this example seems misleading as I don't think you
would ever connect them to the same supply.

> +            vio-supply = <&vio>;
> +            pwms = <&pwm_gen 0 0>;
> +            io-backends = <&iio_backend>;
> +        };
> +    };
> +...


