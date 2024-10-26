Return-Path: <linux-pwm+bounces-3919-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB91A9B19F8
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Oct 2024 19:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5627928289D
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Oct 2024 17:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AEB1CC15F;
	Sat, 26 Oct 2024 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jy01RoNS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAA32F36;
	Sat, 26 Oct 2024 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729962671; cv=none; b=kcwQRId1GZtaAF9DBLC+htzzwNsMWA5s807OfbRRuejhze4agwjQKSoScYrwzSGcTyoQNjvPZ0k/gNczyu5hx4KV9cvSZ4ct3B6YKKCLnoQmkE8sp2Sc/eQYMXbuHQ+A90dPexCyV8Iq8mCj7UOACjaJnd0lPSICXi0GKLjd4YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729962671; c=relaxed/simple;
	bh=wJG7RauQd5nrrvEXZ40WfItE9gp5JKSZNYtYgBx0jII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvtOPELkbbh+4BcJfgCHRJBF41MP9EldI/UDDAocD+bBlmULhQKAnsvqtv61o/XDPMnAS2u6rVODLGD7K9n+ore2Fkl0QJPP8oKxxvlINy5N00RDkFFc6sV+iJTJ6idZ6cE1OFcnde3SrA17y87xXhM7o+YJ7mtgJLIdSV9PdSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jy01RoNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE58C4CEC6;
	Sat, 26 Oct 2024 17:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729962670;
	bh=wJG7RauQd5nrrvEXZ40WfItE9gp5JKSZNYtYgBx0jII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jy01RoNShE6koWDMeKaVLWmHmq2PF1w8ic0RrCiIORPNmfLg2c+XQF8ep6lminENr
	 kbAd1IsfQhrrhjJvfPTUg5Fgx0D/VA1Mpm+ePg9fK6W3kA1VJIoQwkx4A0OiMVYR5C
	 6h+tmFdDTFFTxIqL8j6hDt/R/tTETSQ2+uJR2c2BFWKuRGqlEEyiTyPAVi4zlOdGwf
	 5+FOo4pAvai6XgMtLkPU5t87r7lHeEzPsbLy5yCChtSg0vaVJ2PWI3gjvF3asIHY+n
	 13ymdflpv2tAEoc3XAAPuew3j5KNT3jaFIDg1zEeV3LktesyuELJPxQd0OuMXfgZpZ
	 c4MbsO6V/X2Aw==
Date: Sat, 26 Oct 2024 18:10:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Cc: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>, Rob Herring
 <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Sa, Nuno"
 <Nuno.Sa@analog.com>, "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] iio: adc: ad4851: add ad485x driver
Message-ID: <20241026181031.73d29339@jic23-huawei>
In-Reply-To: <315f158e-0c3b-48e3-b288-27170f0659ed@baylibre.com>
References: <20241014094154.9439-1-antoniu.miclaus@analog.com>
	<20241014094154.9439-6-antoniu.miclaus@analog.com>
	<60452f83-28a1-4a80-8e90-1f1ed32a594e@baylibre.com>
	<CY4PR03MB33996900AAB90A050375CBB39B4F2@CY4PR03MB3399.namprd03.prod.outlook.com>
	<f3351a7f-318b-42d6-aa1a-e8279eb06b78@baylibre.com>
	<315f158e-0c3b-48e3-b288-27170f0659ed@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 14:55:13 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 10/25/24 9:29 AM, David Lechner wrote:
> > On 10/25/24 6:35 AM, Miclaus, Antoniu wrote:  
> >>>  
> > ...
> >   
> >>>
> >>> See the ad7380 driver as an example of how to impelemt this. [2]
> >>>
> >>> [2]: https://urldefense.com/v3/__https://lore.kernel.org/linux-
> >>> iio/20240530-iio-add-support-for-multiple-scan-types-v3-5-
> >>> cbc4acea2cfa@baylibre.com/__;!!A3Ni8CS0y2Y!4LS7UI11XqIHRgT3ckx76VYn
> >>> CyeikpTumyjO0qDTn7eF7Fd-
> >>> jFFL8yqpYcMAxP_u3VC09bfIAB7gW_rvGoM_sEA$
> >>>
> >>> Also, I would expect the .sign value to depend on how the
> >>> input is being used. If it is differential or single-ended
> >>> bipolar, then it is signed, but if it is signle-ended unipoloar
> >>> then it is unsiged.
> >>>
> >>> Typically, this is coming from the devicetree because it
> >>> depends on what is wired up to the input.  
> >>
> >> This topic is mentioned in the cover letter, maybe not argued enough there.
> >> Yes, the go-to approach is to specify the unipolar/bipolar configuration in the devicetree.
> >> But this is a request from the actual users of the driver: to have the softspan fully
> >> controlled from userspace. That's why the offset and scale implementations were added.
> >> Both these attributes are influencing the softspan.
> >>  
> >>>> +	},								\
> >>>> +}  
> >>>  
> > 
> > The cover letter did not get sent, so we did not see this.  
> 
> So please resend it so we can get the full explanation.
> 
> > 
> > Still, I have doubts about using the offset attribute for
> > this since a 0 raw value is always 0V for both unipolar
> > and bipolar cases. There is never an offset to apply to
> > the raw value.
> > 
> > So I think we will need to find a different way to control
> > this other than the offset attribute.  
> 
> I thought about this some more and I have an idea to solve the
> issue without using devicetree or the offset attribute.
> 
> But we should see what Jonathan thinks before implementing this
> in case it isn't a good idea.
> 
> We can expose each voltage input to userspace as two different
> channels, a single-ended channel and a differential channel.

That was common in early drivers - such as the max1363 because they
were well prior to having sufficiently complex bindings to specify
wired channels.  We also have drivers that do this if no channel
subnodes are provided (kind of a fallback).

> 
> For an 8 channel chip, we would have 16 IIO channels (in order
> of scan_index):
> 
> in_voltage0_raw
> in_voltage0-voltage8_raw
> in_voltage1_raw
> in_voltage1-voltage9_raw
> ...
> in_voltage7_raw
> in_voltage7-voltage15_raw
> 
> If you read the voltage using in_voltageX_raw, then the SoftSpan
> for that channel gets set to the 0V to +V value based on
> in_voltageX_scale. Likewise, if you read the in_voltageX-voltageY_raw
> attribute, the SoftSpan gets set to -V to +V according to
> in_voltageX-voltageY_scale.
> 
> For buffered reads, only one of each in_voltageX_raw/in_voltageX-voltageY_raw
> pair can be enabled at the same time (because the chip is simultaneous
> sampling).
> 
This approach is fine as it's pretty much what some existing parts
are doing even if mostly people are these days preferring the
specified channel route.

Jonathan



