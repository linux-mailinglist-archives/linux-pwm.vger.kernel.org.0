Return-Path: <linux-pwm+bounces-7280-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B891FB502E7
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 18:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D810E1C6349D
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A813375C4;
	Tue,  9 Sep 2025 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naRpJOsN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B83304BBA;
	Tue,  9 Sep 2025 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436198; cv=none; b=qW9tdR4a923B5tkhpcZn1VhvalvoQtttkmX7XXT3+fEwWV5nAJf/niiaktSSOOm/F15+GlTiYItTVHeAUL1HzeTErgx2TMTjUh/6Fwl8bhDUD72be8PWdYcJdpKmhKNVdyIecI07SYGEwLsZJjMhtVAi69FRkZIvalnQ0/ziGXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436198; c=relaxed/simple;
	bh=86oIetmqc9J7WTCewXKydBYkVuOv54+Q2w6j4lVDCVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNM95MAnaSmBXoV68LE7YvuN1SE5RghiEkUoqTBPhvKy0EvBn7t70YCfhmCI96S7Vvda1I53jfwQuOdWjToK8C8NhGeAb9OriYaTQckvwOaFcIrd6z71KF6TsE3ket68zQ+ty/28mjMY8H1pnnF735GW8ThhhobfjsLV3Q2QKIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naRpJOsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056B8C4CEF4;
	Tue,  9 Sep 2025 16:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757436198;
	bh=86oIetmqc9J7WTCewXKydBYkVuOv54+Q2w6j4lVDCVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=naRpJOsNlBoCwSEz/sX6N5hdTeUgwBJdc/pijvitIj/TfigQfjtyRiktNnNs7URGm
	 1kvMgd0K9MMqV8kdy3CfUvnwdB/yob8NtZpBlZRnPd2E21r9mfcl2VB+GQdHFKapfK
	 6Mx+Z5+Q1qzLT4inOW21eiXQ05rSe4o6hisQQNf+sP8BbShdXOmS4U1/hJowT8e1AO
	 PIxubXVMnOOKuJV9VbXymSCNA8jsFhS4qhwtCYzoFVVxL2PATE1TgS0/lLPCIGBo7R
	 tAcG6GrI2UuFhCP7943ocyRWP7Qw1WOaBEsmYEwgwb1FnZcyfkFn/f6SfHiO6fVRzp
	 m0fuxxOy0JAbA==
Date: Tue, 9 Sep 2025 11:43:17 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, andreas@kemnade.info,
	lee@kernel.org, ukleinek@kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, krzk+dt@kernel.org,
	devicetree@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: mfd: twl: Add missing sub-nodes for
 TWL4030 & TWL603x
Message-ID: <175743619670.3343063.17627964858670802403.robh@kernel.org>
References: <20250906145905.93845-1-jihed.chaibi.dev@gmail.com>
 <20250906145905.93845-2-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906145905.93845-2-jihed.chaibi.dev@gmail.com>


On Sat, 06 Sep 2025 16:59:03 +0200, Jihed Chaibi wrote:
> Update the main TI TWL-family binding to be self-contained and to fix
> pre-existing validation errors.
> 
> Following maintainer feedback, the simple power and PWM bindings are
> now defined directly within this file, and their legacy .txt files
> are removed.
> 
> To ensure future patches are bisectable, child nodes whose bindings
> are in other patches (audio, keypad, usb, etc.) are now defined using
> a flexible 'additionalProperties: true' pattern. This removes hard
> dependencies between the MFD and subsystem bindings.
> 
> The complete dtbs_check for this binding is clean except for two
> warnings originating from pre-existing bugs in the OMAP DTS files,
> for which fixes have already been submitted separately [1][2].
> 
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> 
> ---
> Changes in v6:
>   - Refactored the ti,twl4030-power compatible schema to be much stricter,
>     removing obsolete board-specific compatibles (-n900, -beagleboard-xm),
>     that were added in v5. The schema now only permits specific, valid
>     fallback combinations. This change is supported by subsequent patches
>     in the same series (2/3) & (3/3), which update the affected DTS files.
>   - Enforced the presence of the compatible property on all relevant
>     sub-nodes by adding 'required: - compatible', closing a key validation
>     loophole.
>   - Applied various formatting cleanups for readability and correctness.
> 
> Changes in v5:
>   - Restructured the entire binding to define properties at the top
>     level instead of if/then blocks, per maintainer feedback.
>   - Added specific compatible enums for new child nodes instead of a
>     generic 'compatible: true'.
>   - Set 'unevaluatedProperties: false' for 'pwm' and 'pwmled' nodes to
>     enforce strict validation.
>   - Expanded 'power' node compatible enum to include all board-specific
>     compatible strings (used in existing device trees, e.g. OMAP3-based
>     boards) for more complete coverage.
>   - Corrected the schema for the 'power' node compatible to properly
>     handle single and fallback entries.
> 
> Changes in v4:
>   - Reworked binding to be independent and bisectable per maintainer
>     feedback by using 'additionalProperties: true' for child nodes.
>   - Added board-specific compatibles to the 'power' node enum.
>   - Added definitions for 'clocks' and 'clock-names' properties.
>   - Renamed 'twl6030-usb' child node to 'usb-comparator' to match
>     existing Device Tree usage (twl6030.dtsi).
>   - Fixed some spelling/grammar erros in the description.
> 
> Changes in v3:
>   - New patch to consolidate simple bindings (power, pwm) and add
>     definitions for all child nodes to fix dtbs_check validation
>     errors found in v2.
> 
> Changes in v2:
>   - This patch is split from larger series [3] per maintainer feedback.
>   - Added missing sub-node definitions, resolving dtbs_check errors.
> 
> [1] https://lore.kernel.org/all/20250822222530.113520-1-jihed.chaibi.dev@gmail.com/
> [2] https://lore.kernel.org/all/20250822225052.136919-1-jihed.chaibi.dev@gmail.com/
> [3] https://lore.kernel.org/all/20250816021523.167049-1-jihed.chaibi.dev@gmail.com/
> ---
>  .../devicetree/bindings/mfd/ti,twl.yaml       | 221 +++++++++++++++++-
>  .../devicetree/bindings/mfd/twl4030-power.txt |  48 ----
>  .../devicetree/bindings/pwm/ti,twl-pwm.txt    |  17 --
>  .../devicetree/bindings/pwm/ti,twl-pwmled.txt |  17 --
>  4 files changed, 210 insertions(+), 93 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.txt
>  delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
>  delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


