Return-Path: <linux-pwm+bounces-7640-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B72DC6B393
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Nov 2025 19:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 982C34E0589
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Nov 2025 18:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFE72D8399;
	Tue, 18 Nov 2025 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y9RvKfGK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035FC2DAFCA
	for <linux-pwm@vger.kernel.org>; Tue, 18 Nov 2025 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490812; cv=none; b=DLc0yTcaVU/wyyCAxcrilm7LRAwAhk9MNm4wE/ITtjtH9TkF2jXirsJJDoAA3P8Om/uwS8w0SU+X1AfqE7DHvA0SoqKCqs2vzfTz0TlzLRznank3xJCY/EY+SvfnMGMJdp6KC0CLvbs6YyN7Fghsj13bqQ5LgYHzgA6zTaiRFnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490812; c=relaxed/simple;
	bh=GcDTjwZY6FU1cNbj8CaVE8U5G2UgV6R7hB62qBK3VAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LpqxmuiZIYjFdc0xCcX+/mnUmGUOl4zgBNAIoOuvF7N4ltWUu14offntN2iPu+bc+D3ENCMk1zN1i2euoNSg3pxrgGcex8iJM84CRvEJbZvG0bLNUW7D626XRFWTg4lr+mZPtWX2ZiUcYLPnKdGN2/oEsopunI2UH4blI6/Lp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y9RvKfGK; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-63f95dc176fso5066314d50.1
        for <linux-pwm@vger.kernel.org>; Tue, 18 Nov 2025 10:33:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763490810; x=1764095610;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wqc5t0x8wwK/4aD9iLC8f2i+EJJUveiqI1qq5wUjwUM=;
        b=xQ6Q2OuDrmAt+zDDDJabhdZTtKloh/Ue2PTj52rrXXdrRqtIMIIu9+BRkD4nRNW3ZN
         lqle3tdZA6iu15GJnJ1hr2YqjJFhabLzrCbnl0pV22KJgdMQIkPPk9Rt4Vr0ArWlPjwF
         7pBdq/n3a/FZRSBs1j7ZDFQVaXAewOyzNVrQBV78xd96r4spu08uBxuS80eF/nLwMXhl
         FAqvwaWyrJx7EkKkQgbMKMc1JoTxquPd06PaJwBG+ED4J3EGmgpUi2jMlGNro6U4+4S6
         //9ySnwj32Hgbw8lIx987GVCeH6Sm7AalKWEy1IdWo6RwZPtbxPvf6nJRq+NDOPmC+bC
         PnmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtY8IvPKG8ecVGjZi3xBEUEEdur+WtEyIWIs62eiLDPOI2asvVRFocHRjLGOIalxwLwcnQ1r5YPp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDwNxVK2fGKr/bOe04jf9QNxNoehqyfC6vmTXTsOu5rAEif2Vb
	MzgKJVGDx77tvUZY5M1IQ4ZOWd+rzzgc2cQfwmiOQV597rFgPkpT/5FA1zmptM6UM0uZ4gEPsxq
	29kZHnJ4sPIZIOYvhQpXfkBfPA4VtDvL48YkgDUSq2Z57yFk9fWp+9VcAhyprE+f/D4a+2EivaZ
	7cYJKrZjDpmsBQtBgEnCg5HunOZgCtIsNW/RgjLJ4Fvhc8L5vuT6iQ3qiMfEn3owGN8VALpqMCG
	mpQ0wx5wUtijRrYu5Zb
X-Gm-Gg: ASbGncuia9yGT3uG++/HpywLNSLzrdflDs2DkscCMMxP4ge710jbttygh/D2xVibC8a
	jQTxcM75HUYG82LJb0JB9q40REu2NQK/Jm679EgkB6IYoik93+NJQT8wc9D5qPG7d84VkCx59N+
	7HTDqhFvdPNVLknLAkHqjlt3/ADE1PbXbM7HkIR6g3RjZhGyBFATBl+c1V9xB42wRvPVXmz7z0R
	SMb17c03+lg40Wp1FCU/JuL3JrDvRbbx0iNLrVXO9SAJofQGEqfSESwEphTpkQLGSnu3oNjXt6V
	glPZDRkyBrZbt4aUU3jeMXKFuaOCCZa+ShEwpSZEYTb76Qfly8RTeQKuZufsYfvFuADoEGXmImU
	JKX5axBxjXea+lcZqIBoW1d98V1dhRmB63+/PRb/8a9m6v/4dfqZiU3EaOXO3lpZbIElMX/rGZw
	CndPXm66JJWWH9WZRmwM14qPO/2I4LoGD435i0D2AzFhhC54aWTQ==
X-Google-Smtp-Source: AGHT+IEbDXiwm+vkbaVde/Bx5aYHyyQrmpb/cDXjdFF4S9ONEgYz+5bm4thQLk+vHqNBCxA67fRq+yJvSlZm
X-Received: by 2002:a53:d00a:0:b0:641:eeca:1733 with SMTP id 956f58d0204a3-641eeca1aacmr13916089d50.61.1763490809952;
        Tue, 18 Nov 2025 10:33:29 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6410eaccde4sm844596d50.9.2025.11.18.10.33.29
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Nov 2025 10:33:29 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso11976507a12.2
        for <linux-pwm@vger.kernel.org>; Tue, 18 Nov 2025 10:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763490808; x=1764095608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wqc5t0x8wwK/4aD9iLC8f2i+EJJUveiqI1qq5wUjwUM=;
        b=Y9RvKfGKTjpRWHVp2rRY/KyV/oElaLl6wp8OI+dao0Mp9C1ZHm3sSy1yE45T+95OH2
         nozWxrhPwVVqcgDe2Bg0FtOLOMYmQ6MBQP/+wqvpEN1gi5HWgAU5lCRe4lZcsrjrDnxn
         H73V6QYls03tRFgD4HR+qJeJWOCcG8z21m5Hk=
X-Forwarded-Encrypted: i=1; AJvYcCXkT7xMH5ljpjz08P5geWYNZV5n4QuFyHtS6Ks3EunpglJlaW9NQEAp2RifWt8R2vmQaMntUIx+V6g=@vger.kernel.org
X-Received: by 2002:a05:7022:4413:b0:119:e56c:18a5 with SMTP id a92af1059eb24-11b40fcf257mr7166861c88.13.1763490808552;
        Tue, 18 Nov 2025 10:33:28 -0800 (PST)
X-Received: by 2002:a05:7022:4413:b0:119:e56c:18a5 with SMTP id a92af1059eb24-11b40fcf257mr7166837c88.13.1763490807583;
        Tue, 18 Nov 2025 10:33:27 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b060885d8sm70093670c88.2.2025.11.18.10.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 10:33:26 -0800 (PST)
Message-ID: <719eeea2-4338-4caf-ba95-ded99d40da5e@broadcom.com>
Date: Tue, 18 Nov 2025 10:33:25 -0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: bcm2835: Make sure the channel is enabled after
 pwm_request()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: Scott Branden <sbranden@broadcom.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Ray Jui <rjui@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 linux-rpi-kernel@lists.infradead.org,
 Florian Fainelli <florian.fainelli@broadcom.com>
References: <20251118174303.1761577-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
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
In-Reply-To: <20251118174303.1761577-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/18/2025 9:43 AM, Uwe Kleine-König wrote:
> The .free callback cleared among others the enable bit PWENx in the
> control register. When the PWM is requested later again this bit isn't
> restored but the core assumes the PWM is enabled and thus skips a
> request to configure the same state as before.
> 
> To fix that don't touch the hardware configuration in .free(). For
> symmetry also drop .request() and configure the mode completely in
> .apply().
> 
> Fixes: e5a06dc5ac1f ("pwm: Add BCM2835 PWM driver")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


