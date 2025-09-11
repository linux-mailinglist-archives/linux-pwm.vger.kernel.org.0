Return-Path: <linux-pwm+bounces-7292-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F8BB5298E
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Sep 2025 09:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2985A00BFF
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Sep 2025 07:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB573265629;
	Thu, 11 Sep 2025 07:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPkkLLRs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7885D201278;
	Thu, 11 Sep 2025 07:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757574428; cv=none; b=KS91TLaT2Pec9hTeLAFB+zR/0wVDTh+wOHxU+vnbWaKqmDdH33Rd/4t1iMYBCGLY6X4lDhtoQGYnTHxLU1kjiATczzPoNC2qQ5slFcqA4WduLiy3NkGbXEJUQhPxvytHM+s8AK0qyZjqFEGN5CjhZnzQ7aAm62APvKPL6Pf65mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757574428; c=relaxed/simple;
	bh=dUfXftg6biMuPteRwGCLgFaVNZ1zdcLPKGP0VMavsGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDQdgE8+yOdTUx4enShsAKjwiwmZXRHfWfrB1qXcUSLEKTj0jyxlglZYpV4DyB0sM5+/dQX26KWY6i/ktIhU+GDq6ulw9dmoHnxMDGSfXZDwsvWMcdA3m0J4Rd48mYFQFDXR0pjbjHLy8b7u/pIoe7lxWLcJvNQUOR+7QZapYZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPkkLLRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16426C4CEF1;
	Thu, 11 Sep 2025 07:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757574428;
	bh=dUfXftg6biMuPteRwGCLgFaVNZ1zdcLPKGP0VMavsGM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KPkkLLRsF5TH69AEG6DEuGtWeo6fXaZgxdwZ4W1lk+Uih1AllGSUiOriJeBjNusM1
	 EhY3A9y85dc0dFuNMEl9bQNNLk7b6lGHst4WPTuvBkIA5L4kpJyItK0xuRYaVS1uk2
	 Ka85VaIQEU27JYrfA8tTu1VJ7qG+L6juqtWym2O5/42veq0g0d2ZLRAY4l5+tkH51G
	 Kk80rBViPxx6Ob8iuNdgG0a/bCGWpmfDJUJNkkfpZDexLIcv2A4orTHkyFbtURQKvW
	 rEEHOl8Ua+5Csj5SeBRIOjuoGAskH9Q8biKeFC4pEh2jUI5XXTO1ivOJ6FAVx19otS
	 IXAcuu5i2+/BA==
Message-ID: <8a8f3589-482c-467c-8a13-199c51e0331a@kernel.org>
Date: Thu, 11 Sep 2025 09:07:02 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] dt-bindings: mfd: twl: Consolidate and fix TI TWL
 family bindings
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Jihed Chaibi <jihed.chaibi.dev@gmail.com>, lee@kernel.org,
 krzk+dt@kernel.org, tony@atomide.com, robh@kernel.org, conor+dt@kernel.org,
 ukleinek@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-omap@vger.kernel.org
References: <20250910160704.115565-1-jihed.chaibi.dev@gmail.com>
 <20250911-dainty-penguin-of-fragrance-9b4cef@kuoka>
 <20250911084323.357caec2@akair>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <20250911084323.357caec2@akair>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/09/2025 08:43, Andreas Kemnade wrote:
> Am Thu, 11 Sep 2025 08:35:32 +0200
> schrieb Krzysztof Kozlowski <krzk@kernel.org>:
> 
>> On Wed, Sep 10, 2025 at 06:07:01PM +0200, Jihed Chaibi wrote:
>>> This version addresses a final piece of feedback from Andreas to make
>>> the twl4030/twl6030-specific child nodes (audio, usb, keypad etc.)
>>> conditional by moving them out of the common block, which now only
>>> contains common properties (rtc, charger, pwm, pwmled..) ensuring
>>> the schema is fully accurate.
>>>
>>> The complete dtbs_check for this binding is clean except for two
>>> warnings originating from pre-existing bugs in the OMAP DTS files,
>>> for which fixes have already been submitted separately [1][2].
>>>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> Acked-by: Uwe Kleine-König <ukleinek@kernel.org>
>>>
>>> ---
>>> Changes in v7:
>>>   - (1/3): Moved twl4030/twl6030-specific child node definitions (audio,
>>>     usb etc.) into the conditional 'if/then' block to improve schema
>>>     accuracy.  
>>
>> Who asked for this? It's wrong code.
>>
> maybe I was not clear there. That was not was I meant. As far as I
> understand, the correct pattern is to define things outside of the
> if/then block and
> then disable it with property-name: false in the if/then block
> Example: Handling of regulator-initial-mode property.

Yes, I read your comment afterwards and that is how I would understand
it as well.

But the patch here is done differently.


Best regards,
Krzysztof

