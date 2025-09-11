Return-Path: <linux-pwm+bounces-7288-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B456CB528F3
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Sep 2025 08:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D063165FF8
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Sep 2025 06:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAEA274B5E;
	Thu, 11 Sep 2025 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQNlHGAG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AFD26B0BE;
	Thu, 11 Sep 2025 06:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572535; cv=none; b=NbVGjXaWqKbxzLXmMspCnGje4vVWcrep949ujWuRRGCuum9Tf3wcyNqC47uiKJfS2/CCT0GLvwqz4EmFU/44Mkcfp/6fjl/AOZf9qbOZwcnuVx21o2BidEJ87LQMCttyICELRv1nJ8x0sIlzEqX4SPRiaTcqWHjdEd+n2rHZ93Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572535; c=relaxed/simple;
	bh=6DTLMJM89tF5/jVK0wcyq6wVr69uLQFAwN/VGS1+y3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gw0Gdh66ahRtpgHLce5ShhxCEY8xhQMLhGiiYTwmgZ/CFbewWv8uNzOMDCsnphmkHjayAun78bgJscBpZLIV6GH6sbpxMyn03oFjaQYXcWU2MwES+kDXt+z8643ReCUv/DTjfbNF1DqeMfBoDY1LLHqrZck91fYbKcu4xRCRljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQNlHGAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82789C4CEFA;
	Thu, 11 Sep 2025 06:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757572535;
	bh=6DTLMJM89tF5/jVK0wcyq6wVr69uLQFAwN/VGS1+y3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQNlHGAGZTPfHCU+Kz12U2j20xer1K82Sf4W99o0iVJTkU5gCZyfgM412weiNlyc6
	 7CS5179vBt/m0Tv5CGHncFNRZidFvjbSYlXnXrvksSUWM5mZ+vH0FISuGdfBkuSDG9
	 a2KchMpfG+M4bUyHnzXAS6DGRucXxvFMH9pShQq+ybqML4NfeP86yAZBFHnHVCR/Qj
	 Eq4kg7ISVUi3vLJqNsnbNsQTmDuNztj73wArCJV4MGeHmZe96oaNETxzGQRF1iYRj7
	 4GP5jBYcOpNrdHu0bZSWl7SvC7lO9kmLiPxn4xF2HloMM9pGCNVaqwWkltXC2eTh7R
	 6TdX9fn17smQg==
Date: Thu, 11 Sep 2025 08:35:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: andreas@kemnade.info, lee@kernel.org, krzk+dt@kernel.org, 
	tony@atomide.com, robh@kernel.org, conor+dt@kernel.org, ukleinek@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-omap@vger.kernel.org
Subject: Re: [PATCH v7 0/3] dt-bindings: mfd: twl: Consolidate and fix TI TWL
 family bindings
Message-ID: <20250911-dainty-penguin-of-fragrance-9b4cef@kuoka>
References: <20250910160704.115565-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250910160704.115565-1-jihed.chaibi.dev@gmail.com>

On Wed, Sep 10, 2025 at 06:07:01PM +0200, Jihed Chaibi wrote:
> This version addresses a final piece of feedback from Andreas to make
> the twl4030/twl6030-specific child nodes (audio, usb, keypad etc.)
> conditional by moving them out of the common block, which now only
> contains common properties (rtc, charger, pwm, pwmled..) ensuring
> the schema is fully accurate.
>=20
> The complete dtbs_check for this binding is clean except for two
> warnings originating from pre-existing bugs in the OMAP DTS files,
> for which fixes have already been submitted separately [1][2].
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
>=20
> ---
> Changes in v7:
>   - (1/3): Moved twl4030/twl6030-specific child node definitions (audio,
>     usb etc.) into the conditional 'if/then' block to improve schema
>     accuracy.

Who asked for this? It's wrong code.

Best regards,
Krzysztof


