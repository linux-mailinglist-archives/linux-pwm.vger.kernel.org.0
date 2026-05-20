Return-Path: <linux-pwm+bounces-9035-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJOzMAdJDmoM9gUAu9opvQ
	(envelope-from <linux-pwm+bounces-9035-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 01:51:35 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E67159CF44
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 01:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83FB4317D2EC
	for <lists+linux-pwm@lfdr.de>; Wed, 20 May 2026 23:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D13C31A555;
	Wed, 20 May 2026 23:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RPeE01F+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27D0355F2A
	for <linux-pwm@vger.kernel.org>; Wed, 20 May 2026 23:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779319910; cv=none; b=FJ0GXhNyfZ/AbvWn7AiToT79eueIf5qf4mhJ/wI6BivcAKe7K61IFEKpdoA7nhVofQambn2yZti+MA5xkATq31jY90bHSyA4yfHQ/QoxF6iodn1nLbYsPBh2v4+GPsfWlPlyd6Yj8RKbHMkEmHZVfTO5NOJ0Fp84qlkLv11KpY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779319910; c=relaxed/simple;
	bh=GCdwdd8L4QYKV9g8Pk5TlKPm1MpJ1P+LBWi8O0BSLsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yjl+MGb6DMWgLQH0EVriQ8P0m/PY+hcNuZ4J9PUVQwP4topcPA7rAZU2Hr1FUeu0T7NJANl7ROJDwTrrrQorgKL10rJfKg57apCabvsFg2ohP8n7j/Kq1vv9o6RqAduBI6IukM37mLZGQeGk6x0Tpfj4+DfYUemGdfQNWcr2Hbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RPeE01F+; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-575171b1ce7so1702384e0c.1
        for <linux-pwm@vger.kernel.org>; Wed, 20 May 2026 16:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779319907; x=1779924707;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nvICw2ZiPKqUfY+3rSfqzqLBbnkDQZGCcIY6G6UcS6g=;
        b=BBPwZ6u7DAU89fd4COgnhWILqeAV4dh5rtC+ZH6OZ1vFgC4gYw+wOCdND6uo6wUi64
         QQO35eZmn+Q7BzeWkFC+tE518Bo7HlK8QPNvRwaQoDPesWIrvk93L4fZK6IgHfyoRl3p
         LrUfDsJ5+V/wxSKx6np801quCH5jp4It03tJb1rSXPKdptcrpD2l/uV3G8J5Df3irSWh
         5C9vueW1B430NBEPxwHC+7eYiKOJMOzQli5m8iqZ24poTvlMb4vWnMaI/dB0FOM5C/iu
         IiFtP7ewfSEyPC/LbZP/QmkHLFNgkebdCte1fopBAmJBAF99odCoXcDEb4MSdkFxv7T3
         JKXA==
X-Forwarded-Encrypted: i=1; AFNElJ8GhAMRd5cNWyeYI2TGO+3vBYFiexhKcirS2AZGlMgI0U7vKt7XNpqadPImFqnO4g10XIfyEBeEqDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJdKwma6hHRVxOOpdcKzDpLjDufCgNKA9yz5WTBVkQJ7l7sXgQ
	DWMTjPKJLV3s9JBZ+a5kL3pkSOOVJoxTQuB5uwCuxcsZnzMcF/+UojU237VXCQAI7/E+DZG/Rv1
	5T0Mk3Gvt9dy0qWwmeAP8ylthodBiLF0xJYA/xztc7Q9bPmK1fZe+iWGEEmb7iUtA4+L9MQ6xE5
	s8spwAT4X/4sPqaYy6hEL6Um1zam2BItUGC0MR+NUIIBefX+GVLtYmTh5aLC5rCOFNuifVB5XZP
	pr3Pkuoio7laGU1Wqdv
X-Gm-Gg: Acq92OEI8cVKqC71/zV1lYVUCBDguqi5IHDdInCFa1y++FMhoVXpxsh3ZIdGRG0pTZk
	lZ9dx2V5NqhQi40q/8t9dfLCw2x0X3GDMdjFCmuYWNHVxJ2CbVX1WwKplFw6mlgq7nt9hVaZedc
	3mxpL1LCnxVkt3YpqsJLQAcz3p0TcK9m76/CunPUptWXJ2xymKGPwvsP0Goy2kJ2jy0miOZ80XI
	3+2wXpCfKfuAALZLkWP+sJDW5NiuhD7AKFOgZvhexCF4+AastqVtXu/47UqgRkEcvFR0Gcp9N/w
	7ecKumBf++4rfVs0sWVNreBHIY1IaX3sqC/U306XdTh0vLzUeeh9PcciHHZHv6T+pcbyWwJYLKr
	al1gD62ahlrGVr/BjfTbP6jn0zyD0yNAb5bltg+TNh9ATfQg7YudxrqdY00MmwSP/h8aSuJr8eG
	AqLJnVjAwzsqktnFQ6Z7nQdm+SN3OvE7moeVO/0Ob2ixKDnGSDhbudCbhje0AAdis/
X-Received: by 2002:a05:6122:6582:b0:56c:da22:6921 with SMTP id 71dfb90a1353d-58425f88587mr230826e0c.5.1779319907585;
        Wed, 20 May 2026 16:31:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5760f84c0d3sm1422531e0c.8.2026.05.20.16.31.46
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2026 16:31:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2f3ec2e8d07so958182eec.1
        for <linux-pwm@vger.kernel.org>; Wed, 20 May 2026 16:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779319906; x=1779924706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nvICw2ZiPKqUfY+3rSfqzqLBbnkDQZGCcIY6G6UcS6g=;
        b=RPeE01F+1f2p8F7+1v5vGonpjuZ+20Hu5T39tmMQgB6pJOW/I/fR7AtfCqES1AnWcx
         GerQcMQZ2jimA2bJcJYD1nmZr9MJOeKinaEJKEZH7ScEWPQXxa4hWu8t5OXH2KFig+V0
         zzvm28WJJuPoAXOCPJV31Oa1KusyRB8z5AK0c=
X-Forwarded-Encrypted: i=1; AFNElJ/jS+E42kl/2/HBTax2sEL8cXuHNJ3rVPKA0qjB4romkukWU63M0apEZn7SB8GdsQ5AjzyH36EHXKA=@vger.kernel.org
X-Received: by 2002:a05:7300:ef89:b0:2c5:60d0:701e with SMTP id 5a478bee46e88-3042f439717mr408624eec.3.1779319905726;
        Wed, 20 May 2026 16:31:45 -0700 (PDT)
X-Received: by 2002:a05:7300:ef89:b0:2c5:60d0:701e with SMTP id 5a478bee46e88-3042f439717mr408577eec.3.1779319904722;
        Wed, 20 May 2026 16:31:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2ea6dsm20241408eec.4.2026.05.20.16.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 16:31:44 -0700 (PDT)
Message-ID: <394b5e02-1aa6-4efe-a5f7-4468d1f82172@broadcom.com>
Date: Wed, 20 May 2026 16:31:42 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Add RP1 PWM controller support
To: Andrea della Porta <andrea.porta@suse.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Naushir Patuck <naush@raspberrypi.com>,
 Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com
References: <cover.1776932336.git.andrea.porta@suse.com>
 <af2bsEdAhYY9c4rb@apocalypse>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <af2bsEdAhYY9c4rb@apocalypse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9035-lists,linux-pwm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:mid,broadcom.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3E67159CF44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/8/26 01:15, Andrea della Porta wrote:
> Hi Uwe,
> 
> On 10:30 Thu 23 Apr     , Andrea della Porta wrote:
>> This patchset adds support for the PWM controller found on the
>> Raspberry Pi RP1 southbridge. This is necessary to operate the
>> cooling fan connected to one of the PWM channels.
>>
>> The tachometer pin for the fan speed is managed by the firmware
>> running on the RP1's M-core. It uses the PHASE2 register
>> to report the RPM, which is then exported by this driver via
>> syscon registers. A subsequent patch will add a new device
>> and driver to read the RPM and export this value via hwmon.
>>   
>> Subsequent patches will also add the CPU thermal zone, which
>> acts as a consumer of the PWM device.
>>
>> Best regards,
>> Andrea
>>
>> CHANGES in V3:
>>
>> - Refactored all the register macros. They now have RP1_PWM_ prefix
>>    and follow the register name.
>> - Dropped the tab alignment in front of struct declarations (use a space
>>    instead).
>> - Added a check in tohw() to test (and bail out quickly) in case that
>>    period_length_ns is zero.
>> - Probing now returns an error if clk_rate > 1 GHz.
>> - Added a check on minimum period ticks. Return 1 to signal round-up.
>> - Fixed inverted polarity detection on edge cases.
>> - Fixed rounding errors (in both tohwi() and fromhw()) in inverted
>>    polarity calculations.
>> - Dropped a redundant check on period >= duty.
>> - Replaced memset by inline struct init.
>> - Disabling a channel now is faster, skipping the duty/period/polarity
>>    setup.
>> - Fixed an error string (s/Fail/Failed)
>> - Used %pe to signal error string instead of an integer.
>> - Added several new sections to the Limitations paragraph to better
>>    explain what will happen on edge cases.
>> - Maximum period is now U32_MAX-1 to allow 100% duty cycle on all
>>    selectable periods.
>> - The hw period register now takes into account for the extra tick at
>>    the end of the period (subtracted one to wfhw->period_ticks in tohw
>>    and added 1 in fromhw).
>> - Added .remove() callback to free resources even if the driver is
>>    not unbindable/unloadable, to avoid accumulating tech debt.
>>
>>
>> Naushir Patuck (2):
>>    dt-bindings: pwm: Add Raspberry Pi RP1 PWM controller
>>    pwm: rp1: Add RP1 PWM controller driver
>>
>> Stanimir Varbanov (1):
>>    arm64: dts: broadcom: rpi-5: Add RP1 PWM node
>>
>>   .../bindings/pwm/raspberrypi,rp1-pwm.yaml     |  54 +++
>>   .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  12 +
>>   arch/arm64/boot/dts/broadcom/rp1-common.dtsi  |  10 +
>>   drivers/pwm/Kconfig                           |   9 +
>>   drivers/pwm/Makefile                          |   1 +
>>   drivers/pwm/pwm-rp1.c                         | 414 ++++++++++++++++++
>>   6 files changed, 500 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
>>   create mode 100644 drivers/pwm/pwm-rp1.c
>>
>> -- 
>> 2.35.3
>>
> 
> A gentle reminder about this patchset :)

Hi Uwe,

I would prefer to take the DTS changes through the Broadcom ARM SoC tree 
to minimize conflicts on my end, are you going to take the PWM patches 
for 7.2? Thanks!
-- 
Florian

