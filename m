Return-Path: <linux-pwm+bounces-7290-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EF1B52917
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Sep 2025 08:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE9D5804BA
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Sep 2025 06:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC242652AC;
	Thu, 11 Sep 2025 06:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXrfYKG9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF18145A05;
	Thu, 11 Sep 2025 06:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572716; cv=none; b=bkSKMxqsrJiV7X4x5h+uxYzt9W63npg3mAiUhY3wIXyJXmi9HiSInHeNq4UIjl7iMo04LDSa/bXcd+t9c3wgGgpOapkIHEqdICSwLlQzprGL2O5rpqp0Dr5VZTwW+gNyHx38Mg4Si9cwMC0gUTyd5ezg5SoPYIolNot88bIklgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572716; c=relaxed/simple;
	bh=gbCwXPLyTC5MhQX1VWb6MXo22NztA5Y6EwS0vFTkdfg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pOX85zTZKvD63SbPWT1u6qwy3b6hMvpdXulYezj4ZgJTcxsuSIHqvFAsslO7j3O5lcW/c4ypOkr5HwVefHBPLfmBNoETZjWvksdrdBUa9J0ninZCCZmVTtnqbkeUDIaZyKP/Bk3E0U0wk3B8bhuqU1m/1PuP03c0MnEfkny2cmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXrfYKG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AC3C4CEF7;
	Thu, 11 Sep 2025 06:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757572715;
	bh=gbCwXPLyTC5MhQX1VWb6MXo22NztA5Y6EwS0vFTkdfg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=mXrfYKG9IuvTt7X/Lv4CPK91XkPR7h4c+KsutnOj8KaO4KO2xYBKPk4bFcAXMmuUL
	 KStPeFC0sMrn95DFXDbcV+XE3qZKoNSVE8T1/D/pn47YXVxoptom2S3SGefpKeLXOS
	 ykefA03LN7Yj6bjgvHOsXNTaCnrS1v5No7wNG0rg6oEQEs+iWJAyEtJ4j68U22TJCZ
	 tlRtZJtBeKnW6R/wovJd0C3JyGefvnjFGsG4zKzmdQE2hdFxtoJ8BCvpmYfXLkrsvx
	 D4wbm9bPHCLtHEpxPZ9CnrB1pvhThJ8wZxWrPf6dBr58Mc0aI9dj7Cec93asulg8G8
	 Oti4nISZHvGtg==
Message-ID: <6679d951-a572-49e8-b847-e59f33692d77@kernel.org>
Date: Thu, 11 Sep 2025 08:38:31 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] dt-bindings: mfd: twl: Add missing sub-nodes for
 TWL4030 & TWL603x
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: andreas@kemnade.info, lee@kernel.org, krzk+dt@kernel.org,
 tony@atomide.com, robh@kernel.org, conor+dt@kernel.org, ukleinek@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org
References: <20250910160704.115565-1-jihed.chaibi.dev@gmail.com>
 <20250910160704.115565-2-jihed.chaibi.dev@gmail.com>
 <20250911-curvy-doberman-of-thunder-1ef4aa@kuoka>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250911-curvy-doberman-of-thunder-1ef4aa@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/09/2025 08:36, Krzysztof Kozlowski wrote:
> On Wed, Sep 10, 2025 at 06:07:02PM +0200, Jihed Chaibi wrote:
>> Update the main TI TWL-family binding to be self-contained and to fix
>> pre-existing validation errors.
>>
>> To ensure future patches are bisectable, child nodes whose bindings
>> are in other patches (audio, keypad, usb, etc.) are now defined using
>> a flexible 'additionalProperties: true' pattern. This removes hard
>> dependencies between the MFD and subsystem bindings.
>>
>> The complete dtbs_check for this binding is clean except for two
>> warnings originating from pre-existing bugs in the OMAP DTS files,
>> for which fixes have already been submitted separately [1][2].
>>
>> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
>>
>> ---
>> Changes in v7:
>>   - Moved twl4030/twl6030-specific child node definitions (audio, usb..)
>>     into the conditional 'if/then' block to improve schema accuracy.
>>
>> Changes in v6:
>>   - Refactored the ti,twl4030-power compatible schema to be much stricter,
>>     removing obsolete board-specific compatibles (-n900, -beagleboard-xm),
>>     that were added in v5. The schema now only permits specific, valid
>>     fallback combinations. This change is supported by subsequent patches
>>     in the same series (2/3) & (3/3), which update the affected DTS files.
>>   - Enforced the presence of the compatible property on all relevant
>>     sub-nodes by adding 'required: - compatible', closing a key validation
>>     loophole.
>>   - Applied various formatting cleanups for readability and correctness.
>>
>> Changes in v5:
>>   - Restructured the entire binding to define properties at the top
>>     level instead of if/then blocks, per maintainer feedback.
>>   - Added specific compatible enums for new child nodes instead of a
>>     generic 'compatible: true'.
>>   - Set 'unevaluatedProperties: false' for 'pwm' and 'pwmled' nodes to
>>     enforce strict validation.
>>   - Expanded 'power' node compatible enum to include all board-specific
>>     compatible strings (used in existing device trees, e.g. OMAP3-based
>>     boards) for more complete coverage.
>>   - Corrected the schema for the 'power' node compatible to properly
>>     handle single and fallback entries.
>>
>> Changes in v4:
>>   - Reworked binding to be independent and bisectable per maintainer
>>     feedback by using 'additionalProperties: true' for child nodes.
>>   - Added board-specific compatibles to the 'power' node enum.
>>   - Added definitions for 'clocks' and 'clock-names' properties.
>>   - Renamed 'twl6030-usb' child node to 'usb-comparator' to match
>>     existing Device Tree usage (twl6030.dtsi).
>>   - Fixed some spelling/grammar erros in the description.
>>
>> Changes in v3:
>>   - New patch to consolidate simple bindings (power, pwm) and add
>>     definitions for all child nodes to fix dtbs_check validation
>>     errors found in v2.
>>
>> Changes in v2:
>>   - This patch is split from larger series [3] per maintainer feedback.
>>   - Added missing sub-node definitions, resolving dtbs_check errors.
>>
>> [1] https://lore.kernel.org/all/20250822222530.113520-1-jihed.chaibi.dev@gmail.com/
>> [2] https://lore.kernel.org/all/20250822225052.136919-1-jihed.chaibi.dev@gmail.com/
>> [3] https://lore.kernel.org/all/20250816021523.167049-1-jihed.chaibi.dev@gmail.com/
>> ---
>>  .../devicetree/bindings/mfd/ti,twl.yaml       | 232 +++++++++++++++++-
>>  .../devicetree/bindings/mfd/twl4030-power.txt |  48 ----
>>  .../devicetree/bindings/pwm/ti,twl-pwm.txt    |  17 --
>>  .../devicetree/bindings/pwm/ti,twl-pwmled.txt |  17 --
>>  4 files changed, 221 insertions(+), 93 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.txt
>>  delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
>>  delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
>> index f162ab60c09b..95238a10ecda 100644
>> --- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
>> @@ -9,11 +9,13 @@ title: Texas Instruments TWL family
>>  maintainers:
>>    - Andreas Kemnade <andreas@kemnade.info>
>>  
>> -description: |
>> +description: >
> 
> Why?
> 
>>    The TWLs are Integrated Power Management Chips.
>> -  Some version might contain much more analog function like
>> +
>> +  Some versions might contain much more analog functionality like
>>    USB transceiver or Audio amplifier.
>> -  These chips are connected to an i2c bus.
>> +
>> +  These chips are connected to an I2C bus.
>>  
>>  allOf:
>>    - if:
>> @@ -62,6 +64,7 @@ allOf:
>>          pwrbutton:
>>            type: object
>>            additionalProperties: false
>> +
>>            properties:
>>              compatible:
>>                const: ti,twl4030-pwrbutton
>> @@ -73,9 +76,109 @@ allOf:
>>          watchdog:
>>            type: object
>>            additionalProperties: false
>> +
>>            properties:
>>              compatible:
>>                const: ti,twl4030-wdt
>> +
>> +        audio:
> 
> Don't define properties in conditional block.

Really, I don't understand. You got review from the DT maintainer, you
got other ack and you drop both and introduce a completely odd change
(it's even documented in writing bindings not to do that change).

No, revert to v6 and re-apply all the tags you received.

Best regards,
Krzysztof

