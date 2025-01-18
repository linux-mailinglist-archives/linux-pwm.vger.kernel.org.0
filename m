Return-Path: <linux-pwm+bounces-4678-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D758A15E5F
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jan 2025 18:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360F73A6F6E
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jan 2025 17:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AD01A0706;
	Sat, 18 Jan 2025 17:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBrU1LeI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307672913;
	Sat, 18 Jan 2025 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737222106; cv=none; b=tZI9+xRz1auipK7yGdwJ2ViRd568qlmWR8hJ/7A27YCNlPt0nqw42SG5LM3N+GBeSbSq2fAokScjOgwHeZVLNenAs4q8oAkv9eUDH86FxicdSHlsIwPWhOk3fXSWsfj9Y55MwpVkqoVuu8kuJ/PsbtSftufLt+GcDtA86kpF+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737222106; c=relaxed/simple;
	bh=DwlYDOXc0BhTEpSNVbXSLN0CX12gPUS0lPThlAg36Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKEVQhj0SW4kNPiwgV12lVXyEB6lM2fnHTak3btNrmULA9ONQOSu+GQNuTH477o6Qb4RWg2tUb5Z2xbrtaidI631BS5g9gZH5z3FTzS3mye3RuboXulbPXEkfHD/vIve5M6aQIwzzMxwYCfP7UT43IrTeKWMZTsVmW/0mL+l4tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBrU1LeI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607FEC4CED1;
	Sat, 18 Jan 2025 17:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737222104;
	bh=DwlYDOXc0BhTEpSNVbXSLN0CX12gPUS0lPThlAg36Eo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OBrU1LeIZi3cxhPTNpeWz5vqV80/Ow6k5votWb6QuM39g2ZIKSYCnne0Voxi5BbKl
	 kiNnyAVw0wD5q4vvsPtbul1jLLS6eG2Uhx9sCKrPcvGGlGyP3nMcl3TwFw5FkNMX4k
	 j7v6shdJzoIQgWZzkRdSR91dRJ0aoV0JVB+B1hFrvl7suzD6CU95zOtJWt2Nhymr06
	 KNUC9sAys0Vh5sP+lfmA/sxw36ZnwqKJKIGe8Vrs/lJQDNYQvpNVl5kE9ocx+lGL6C
	 q6Jtbf9w7uBdiJcYTkZGjrXXDWKhLsR/CtmGYX5Cb+Qj4tCdUNwFX5l+Iet1Y+yVwt
	 j8qjG/HbUQHIw==
Date: Sat, 18 Jan 2025 17:41:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, robh@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v10 8/8] iio: adc: ad4851: add ad485x driver
Message-ID: <20250118174135.1f6e24a3@jic23-huawei>
In-Reply-To: <134bd7b9-f659-4010-9c78-48eee1dc901a@baylibre.com>
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
	<20250117130702.22588-9-antoniu.miclaus@analog.com>
	<d4b9d6e9-745c-4c35-a62d-18e0a36f30c4@baylibre.com>
	<20250118165751.334fe37b@jic23-huawei>
	<134bd7b9-f659-4010-9c78-48eee1dc901a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Jan 2025 11:09:12 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/18/25 10:57 AM, Jonathan Cameron wrote:
> > On Fri, 17 Jan 2025 15:45:35 -0600
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> On 1/17/25 7:07 AM, Antoniu Miclaus wrote:  
> 
> ...
> 
> >>> +		if (fwnode_property_present(child, "diff-channels")) {
> >>> +			*channels = ad4851_chan_diff;
> >>> +			channels->scan_index = index++;
> >>> +			channels->channel = reg;
> >>> +			channels->channel2 = reg;    
> >>
> >> Typically we don't set channel == channel2 for differential channels.  
> > So i guess this is tripping up on these being dedicated pairs labelled
> > +IN1,-IN1 on the datasheet.  The binding documents those as matching
> > the diff-channels - hence both channels and reg are the same.
> > So maybe best bet is to enforce that in the driver by checking it is
> > true.  
> 
> Are you saying that in_voltage0-voltage0_raw in userspace is OK?
That is indeed the question.  It's odd.. 

Also causes us problems because we do have a few devices where we
actually do read a single pin wired to either side of a differential ADC
as part of calibration where in_voltage0-voltage0_raw has
a different meaning to here.

So, gut feeling - too odd and I think every time we've met this
before we have gone with inventing some more channels so that the
inputs have different numbers.  I can't immediately point at an
example though.

Do we need to handle that at the binding level? I'm not sure
if it is clearer to insist we do in both places or let the binding
stick to datasheet numbering and just deal with inventing channel
numbers in the driver.

Jonathan

> 
> > 
> > It is a slightly weird description but only alternative would be to
> > invent some more channel numbers for the negative sides which is
> > less than ideal.  We could go that way though.
> > 
> > Some comments alongside a sanity check is probably the best way to
> > handle this and no surprise us in the future.
> >   


