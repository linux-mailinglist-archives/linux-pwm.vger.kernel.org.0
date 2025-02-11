Return-Path: <linux-pwm+bounces-4860-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D53E8A31602
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 20:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A7627A412A
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 19:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AF8265614;
	Tue, 11 Feb 2025 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9F/IQ8P"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A767C265602;
	Tue, 11 Feb 2025 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303639; cv=none; b=BIQGy0zVE7iMgnrmA73N/0l7w+HVUvBb+HyqwjIlP3dm3xoaOKj12iCj8G+E1E4AqauNHr9bQiEkOe+kIgbThrwHWYmiPpSW9FC4nRyE2yIAE8cEAOoeEDEs17tScp/3Ee66C+WKyvw0JgI82xO22tg9pHt1xG5jTyMjRa+/fqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303639; c=relaxed/simple;
	bh=IxYvfyovUNcDI5USK3wHo2cjirVOuW1enOAgQxSKOxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pcg3jAuyIZDUZOJECF9BQvswWvxR+ulAwCJJavYGxyd6AvkoDFjtFSufhsrQ9fcSX5i6tnY2eD3xVtRIxHHUPvZvnSKIYYJqScY3hCVuVw88cwN8KfttJaNiosUbvbC46VieJ4gwv8d6gvQFWknWuAELgerjWQ4YOycklmF6D3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9F/IQ8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67C1C4CEDD;
	Tue, 11 Feb 2025 19:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739303639;
	bh=IxYvfyovUNcDI5USK3wHo2cjirVOuW1enOAgQxSKOxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R9F/IQ8PhHOb+h+6BJ1CZUSgqqPucjET++LPobJpyG0cEE+DCzPQQgPT9J39J4ahA
	 S1OHmC0MB7ZODQW0r8VXcWTn8W+qhYOm8cfKkNpe0zPt8pX9Wb+FrrLAx6Ll/oyas3
	 /tQgcZ1Q2YfF5rM9axNANhNmWX4R6QC1hQ+ofxIrRxgJr0V/Dbu7v6+cZNYaN2eES5
	 /oCDCMlaWeMMSFHRtjRz251Rct9W2UO1hgM3A41JEj9j+xF5f6kbiSswdyIKHitQql
	 Vg3e5YKBHerelGnTZZEYGRmHB2nNyllkMDA1UKbv+L99N6hgT4EmMKIH8Go8V4HpcX
	 aYMv8M1CtuoBA==
Date: Tue, 11 Feb 2025 19:53:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, robh@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v12 5/9] dt-bindings: iio: adc: add ad485x axi variant
Message-ID: <20250211195351.5331b2e6@jic23-huawei>
In-Reply-To: <20250211-industrious-rugged-gecko-9b5c02@krzk-bin>
References: <20250207140918.7814-1-antoniu.miclaus@analog.com>
	<20250207140918.7814-6-antoniu.miclaus@analog.com>
	<20250208162058.3b50ae20@jic23-huawei>
	<20250211-industrious-rugged-gecko-9b5c02@krzk-bin>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 09:16:31 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Sat, Feb 08, 2025 at 04:20:58PM +0000, Jonathan Cameron wrote:
> > On Fri, 7 Feb 2025 16:09:14 +0200
> > Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> >   
> > > Add a new compatible and related bindings for the fpga-based
> > > AD485x AXI IP core, a variant of the generic AXI ADC IP.
> > > 
> > > The AXI AD485x IP is a very similar HDL (fpga) variant of the
> > > generic AXI ADC IP, intended to control ad485x familiy.  
> > 
> > Hmm. Should we name this after a specific part? Very unlikely
> > the wildcard will go wrong here because of how specific this
> > binding is anyway but we should perhaps stick to normal rules
> > of no wild cards.  
> 
> I am pretty sure we had this discussion about this or other block
> already and we reached some sort of concensus... which is undocumented
> in commit msg, so we are doomed to repeat the discussion.
> 
Having just seen similar the axi-ad7606x support. I think the key bit
I was missing here is that ADI has published the firmware under the
name with wild card. If they shoot themselves in the foot in future
then fair enough.  I'm fine with the wild card though a statement
in the commit to make me notice that detail would have been great!

Jonathan

> Best regards,
> Krzysztof
> 


