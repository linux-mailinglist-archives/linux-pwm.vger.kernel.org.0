Return-Path: <linux-pwm+bounces-4841-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EC8A30580
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 09:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4203A73EE
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Feb 2025 08:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377291EDA2B;
	Tue, 11 Feb 2025 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TinWPZjg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1BC1B6CE5;
	Tue, 11 Feb 2025 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261795; cv=none; b=WkOmjy9cC79wdV6yWTWBqWQ3AggLqEkzt6YXO6mMuDliDhUXJb24Yto1yN5fiBQBnkbZQbByu9iKFKI/iX3nf4eGDJ3HwKFw56sEVG7ir5QIAypZI8ofiypaVBlAC4HCWvw4+vqfeO6WAVf4NYwgz6q/reKtjWOwzL/G9K9qPTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261795; c=relaxed/simple;
	bh=+u+5GUAVu2gY43K/hasdrUu8RXdP+Ha6+AiaUUtPgl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTHeDCSk9HL08zGr/2Q28ieTPs9x2AetrsXS5+45bcF9spaJCVDCJlvboaqBxoVHew2ZPxQCmxlUf9QQyWTzce8q5llKZv9e/5drrDjh8YjWclAmUDUslIUfx0AJFq2TENRfKYC4CMrlkc/LDjlpvQ4S6/rjoC0uF7gyeqy/6IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TinWPZjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE823C4CEDD;
	Tue, 11 Feb 2025 08:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739261794;
	bh=+u+5GUAVu2gY43K/hasdrUu8RXdP+Ha6+AiaUUtPgl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TinWPZjgpSeo38CN9Be9w4b0lLOtgzlBPWr47JtzIpP4gvZ16FxD96VxkGp0krQFh
	 4bMeOpIaaUdPaVFTAVkNRTMLLYmQbIb5pMxTObMWrBcRe2bkU8eH/9SX0bOfOJ6S0P
	 ejFiT9S9zg0tf/M7UELbCGqT+F6Szf+MrE0Y8P33zgMB/fKfgcS3xRBvDX605FyFGx
	 ZvquVVzXXGf110FQPuabOC9JryVhUc1sYMI3kQuaWINwMFLts15mLabaogNdB1GOQW
	 tQiuNs7fl19NUHDS9273aNxNRxtodIRNlK3CbhFrXcJF7w+1fret4n+4GqyzYrtiO8
	 1znYlrYbPN99Q==
Date: Tue, 11 Feb 2025 09:16:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, robh@kernel.org, 
	conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v12 5/9] dt-bindings: iio: adc: add ad485x axi variant
Message-ID: <20250211-industrious-rugged-gecko-9b5c02@krzk-bin>
References: <20250207140918.7814-1-antoniu.miclaus@analog.com>
 <20250207140918.7814-6-antoniu.miclaus@analog.com>
 <20250208162058.3b50ae20@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250208162058.3b50ae20@jic23-huawei>

On Sat, Feb 08, 2025 at 04:20:58PM +0000, Jonathan Cameron wrote:
> On Fri, 7 Feb 2025 16:09:14 +0200
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> 
> > Add a new compatible and related bindings for the fpga-based
> > AD485x AXI IP core, a variant of the generic AXI ADC IP.
> > 
> > The AXI AD485x IP is a very similar HDL (fpga) variant of the
> > generic AXI ADC IP, intended to control ad485x familiy.
> 
> Hmm. Should we name this after a specific part? Very unlikely
> the wildcard will go wrong here because of how specific this
> binding is anyway but we should perhaps stick to normal rules
> of no wild cards.

I am pretty sure we had this discussion about this or other block
already and we reached some sort of concensus... which is undocumented
in commit msg, so we are doomed to repeat the discussion.

Best regards,
Krzysztof


