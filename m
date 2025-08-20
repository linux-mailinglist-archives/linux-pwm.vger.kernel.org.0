Return-Path: <linux-pwm+bounces-7122-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8E8B2E694
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 22:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 03A454E2203
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 20:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ACB29ACF0;
	Wed, 20 Aug 2025 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVkiA4lE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AE6222584;
	Wed, 20 Aug 2025 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755721760; cv=none; b=VOdQd5vNwwMGrUUKJDcC+q5vkwuydv/AeCj30Ye07c03zo4VoXQvD+xYAvNQoI3wts2MAm8uwC9kLrOop5YPhxcytR1ZpOgER01fwt1aPQNHqQw3cYKjL8fUFKoPhp8ivRneIOfpqBAvy1+yr1NrYSAkcnBv8erJjPEXMpZdQK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755721760; c=relaxed/simple;
	bh=HcyWhHYY9JhEEBlHeHLGeaFUP2meJGrbBVU/uLc1Zrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cc+NMi5HijkILpaBVSyOcpcuyOY/pL8551dyydFkGcwWNk4c4IU4tQxY3dfaMKAr6/5kn4EBay3qeaOGShrMXVB/cTBfdBhbglGQ2RkdSKJOsBA04i/7Vh87Bed9mw4ChoSU638Qdtsl7G/hbVBPxani9eI5L/Rl5Jfg+G36/ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVkiA4lE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53129C4CEE7;
	Wed, 20 Aug 2025 20:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755721759;
	bh=HcyWhHYY9JhEEBlHeHLGeaFUP2meJGrbBVU/uLc1Zrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rVkiA4lE7D62aYH0SIT7xnsXrUwcpKnAR5dpM8bSCR7+14a+kr/bXsxW+dRCVsmxi
	 D0eckedBV4+r+zhyEG+X0b9aqtut3MmHjjemASfjw1AOQFQrkXkjJcQEZwohoz/PdF
	 iIhNBFdVzXMh+07O1lbx5qP01J+u/ALPUOvj8jWDiYQuWs06T9vhhtqiWU+0PIt1+i
	 XlgOLSNpysr3DivNr9PAbRcGzjCtTCSqO0tcnT+ul+1+7vW0+nIqKUA6I06sjClJkH
	 +c96pWm/f/yvlQuxvllkSZ58TO6G2srari1DLY01l9neoC9Yeuc7/QT/TbyqY7tR+H
	 yLd8jIlwJseGA==
Date: Wed, 20 Aug 2025 15:29:18 -0500
From: Rob Herring <robh@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/7] dt-bindings: pwm: renesas,rzg2l-gpt: Document RZ/G3E
 support
Message-ID: <20250820202918.GA712198-robh@kernel.org>
References: <20250814184115.192930-1-biju.das.jz@bp.renesas.com>
 <20250814184115.192930-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814184115.192930-2-biju.das.jz@bp.renesas.com>

On Thu, Aug 14, 2025 at 07:41:05PM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Document support for the GPT found on the Renesas RZ/G3E (R9A09G047)
> SoC.
> 
> The GPT IP on these parts is similar to that on RZ/G2L but supports
> only 8 interrupts per channel and has multiple clocks and resets.
> Introduce a new compatible string `renesas,r9a09g047-gpt` for RZ/G3E.

Doesn't look like a lot in common to me. I think this should be a 
separate document.

> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 525 ++++++++++++------
>  1 file changed, 356 insertions(+), 169 deletions(-)

