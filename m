Return-Path: <linux-pwm+bounces-9620-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yjLBGK70TGoosgEAu9opvQ
	(envelope-from <linux-pwm+bounces-9620-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Jul 2026 14:44:30 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C4D71B79C
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Jul 2026 14:44:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=Wob3Tug0;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9620-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9620-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C52D630675D7
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jul 2026 12:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5F2412297;
	Tue,  7 Jul 2026 12:44:04 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D563F4DC1
	for <linux-pwm@vger.kernel.org>; Tue,  7 Jul 2026 12:44:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783428244; cv=none; b=O28o+TmZzJ+llZBgSH5WBPUJ9YxODag/24Hy4uhkSwqCnHKDSuQZh2wweeCp9RQVkbzCdWmEnxx+UNi9BNqIuKNZO6VUCe6WmCAVlos2TEBbFAAEuXIkyYK9/MTnjtNeITnFIhK7Y2XU8q+Fcy2Hl1lMXvnE7CZ2jAus4PXc5PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783428244; c=relaxed/simple;
	bh=CDnqZHdocFig8h3Tanxr3bQlY6m1Sfvqwn7GqTyyedY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fWdPtUnjwNVe2switHEhGwROQTjqpBt1EFeojBruKa7dGLBun6cQNnbc0I3xrPOb+lwMOgKh0Wfd9HJlP5Upqgz4fnVqxbmip+SEimUQnQKOYMo9kAGu7U1jKaKERu58QLUpwObz6YdroX+N8uTl1Xh2erGGVJd4tGBhMcrKMao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wob3Tug0; arc=none smtp.client-ip=209.85.208.53
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69a50b818c8so3282902a12.2
        for <linux-pwm@vger.kernel.org>; Tue, 07 Jul 2026 05:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783428241; x=1784033041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vVwOc/plNKfiMmUT69quLhKzOtBT2oBK3V8CnUtJXVU=;
        b=Wob3Tug0SChROsyJ9ZGsbpiem0BTQHolSc59VZsRh6nprqJjG1nzgQ8MJtWCSSIKmz
         kzGw72TUnEX+Vjwk/qsyyIlFAbK6zf6J+p5AunRyeSQC/ozRafgtICihpxCQ0FSiGv7L
         IbbO38QNvRLlAGrxSagVZB3bI23fKVLqYhqGvdemjiU+QWSdC8QISF2Tqm4oAN6FU5uH
         Oocizr6nASlrHwaXVjrShY31SwHVDewPo1yyLJwYodvQcx5YZ2yLWxctsRs02L/7fkoa
         4+6fCgNHmYJtKSULsN09Bol2Ou9PnIUDkAbR03d+OjEvc5O8dXpYZnxS/kBJhE+Ug93S
         xJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783428241; x=1784033041;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVwOc/plNKfiMmUT69quLhKzOtBT2oBK3V8CnUtJXVU=;
        b=pzepohdJHLsPxzTtE/LOar0eKMB9e7yGvj2/nkyvO2qIpvpdoxkKWRDVdMODUR6N7i
         u/GeTzz3VubBatlcS8csuh4Q1ewBlJ1RE40gxbXvAD2eiaAzP+Y60d6cri1FR1IvBAl/
         XBWLGS7F+nuY4A0tzIpcAkqpWkzPKb9AQgS7Ii64BxbbPSjyysrVYDfX77Ke4miekHgy
         GdGYN32qqOQo1tp4lMRzotVtXjtnow+fCJgeO5tD6fBiMRfhTPbIpwT3P1hVEdT3SdRR
         4DW38twU8bqdgFFQlqh42CfhNUQfbTnZru7so6xsN+g0ryV5zDA0qD/gZFDez1WCkHWD
         nr8Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro8NfKgEMDxXZmZ123luGcvS8QgZd/8ggayZdSqTAPY3yGE7H0xtvNb2TegdDco47NcLs2LFAkWtRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs6NaCASgoT1buR260uYU+COsVPq27GxjCYBVIsYHIk679bbGI
	GaKpc84EhN9VhUmyOU9tDrh2OYiTGrapW6+D1bkn2JZEwndFFED2QghT2OjPNDVac2Y=
X-Gm-Gg: AfdE7ckjFUYPMMSCquGpCqikTryLFPpR8uyiVIhu4nyvL8jzyKJkxyZNiXNX9wn9oe6
	QuCI4AGpF+RSIQvNaP4E7jsXWS2HgKxaDsEKquupvcsAzYrO8Tdh3OVfKGrlg2jhAqyRfv/Qbw1
	aesGoinBpeUQErvnBIAb7Q5bWsAwMECWng3Uq3PRrBoHCOLRO0JHHlLxGgkd7WSIoSXAzHlqPQi
	YEBZfS+UAMoDw/ez2oYQ7Bo6Ox43KwvAIqz1DREO5pugCJ6k3QvpYMY0mqC1sddSc1cEfGPhL0M
	Rgka/XW4Jub4JQ0rc61sgIuX8ZuzuR6o/DmNEOhCxKqJkNYcYfjCoJtngS+z4BxRvOvyffpUnfM
	1DEAplt9/PDoxbzG++CzjgZuEhMucIE8EeaRbTU4N4LFI82LxkHI3cgdpPgETd6QzFBl/gZrufD
	HoCmujjjAnT3IY+tm/pK2h5WMvCLPQBL7fR+LUV4GtmVMjtKB+Ux/Xb2SiV8o2
X-Received: by 2002:a05:6402:40cf:b0:69a:a4bb:bfc0 with SMTP id 4fb4d7f45d1cf-69aa4bbc2e2mr209995a12.11.1783428241439;
        Tue, 07 Jul 2026 05:44:01 -0700 (PDT)
Received: from [192.168.2.177] (48.85-85-171.dynamic.clientes.euskaltel.es. [85.85.171.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19ce4ad4sm5751522a12.12.2026.07.07.05.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 05:44:01 -0700 (PDT)
Message-ID: <53f3621f-3888-45f3-b319-95efa36fb0f2@suse.com>
Date: Tue, 7 Jul 2026 14:43:59 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] arm64: dts: broadcom: rpi-5: Add RP1 PWM node
To: Andrea della Porta <andrea.porta@suse.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Naushir Patuck <naush@raspberrypi.com>,
 Stanimir Varbanov <svarbanov@suse.de>, Sean Young <sean@mess.org>,
 Julian Braha <julianbraha@gmail.com>
References: <cover.1783097764.git.andrea.porta@suse.com>
 <300b6fb4ba2c9399297b4bd85cbb3bc14f08f6b7.1783097764.git.andrea.porta@suse.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 xsFNBFP1zgUBEAC21D6hk7//0kOmsUrE3eZ55kjc9DmFPKIz6l4NggqwQjBNRHIMh04BbCMY
 fL3eT7ZsYV5nur7zctmJ+vbszoOASXUpfq8M+S5hU2w7sBaVk5rpH9yW8CUWz2+ZpQXPJcFa
 OhLZuSKB1F5JcvLbETRjNzNU7B3TdS2+zkgQQdEyt7Ij2HXGLJ2w+yG2GuR9/iyCJRf10Okq
 gTh//XESJZ8S6KlOWbLXRE+yfkKDXQx2Jr1XuVvM3zPqH5FMg8reRVFsQ+vI0b+OlyekT/Xe
 0Hwvqkev95GG6x7yseJwI+2ydDH6M5O7fPKFW5mzAdDE2g/K9B4e2tYK6/rA7Fq4cqiAw1+u
 EgO44+eFgv082xtBez5WNkGn18vtw0LW3ESmKh19u6kEGoi0WZwslCNaGFrS4M7OH+aOJeqK
 fx5dIv2CEbxc6xnHY7dwkcHikTA4QdbdFeUSuj4YhIZ+0QlDVtS1QEXyvZbZky7ur9rHkZvP
 ZqlUsLJ2nOqsmahMTIQ8Mgx9SLEShWqD4kOF4zNfPJsgEMB49KbS2o9jxbGB+JKupjNddfxZ
 HlH1KF8QwCMZEYaTNogrVazuEJzx6JdRpR3sFda/0x5qjTadwIW6Cl9tkqe2h391dOGX1eOA
 1ntn9O/39KqSrWNGvm+1raHK+Ev1yPtn0Wxn+0oy1tl67TxUjQARAQABzSRNYXR0aGlhcyBC
 cnVnZ2VyIDxtYnJ1Z2dlckBzdXNlLmNvbT7CwXgEEwECACIFAlV6iM0CGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAAAoJENkUC7JWEwLx6isQAIMGBgJnFWovDS7ClZtjz1LgoY8skcMU
 ghUZY4Z/rwwPqmMPbY8KYDdOFA+kMTEiAHOR+IyOVe2+HlMrXv/qYH4pRoxQKm8H9FbdZXgL
 bG8IPlBu80ZSOwWjVH+tG62KHW4RzssVrgXEFR1ZPTdbfN+9Gtf7kKxcGxWnurRJFzBEZi4s
 RfTSulQKqTxJ/sewOb/0kfGOJYPAt/QN5SUaWa6ILa5QFg8bLAj6bZ81CDStswDt/zJmAWp0
 08NOnhrZaTQdRU7mTMddUph5YVNXEXd3ThOl8PetTyoSCt04PPTDDmyeMgB5C3INLo1AXhEp
 NTdu+okvD56MqCxgMfexXiqYOkEWs/wv4LWC8V8EI3Z+DQ0YuoymI5MFPsW39aPmmBhSiacx
 diC+7cQVQRwBR6Oz/k9oLc+0/15mc+XlbvyYfscGWs6CEeidDQyNKE/yX75KjLUSvOXYV4d4
 UdaNrSoEcK/5XlW5IJNM9yae6ZOL8vZrs5u1+/w7pAlCDAAokz/As0vZ7xWiePrI+kTzuOt5
 psfJOdEoMKQWWFGd/9olX5ZAyh9iXk9TQprGUOaX6sFjDrsTRycmmD9i4PdQTawObEEiAfzx
 1m2MwiDs2nppsRr7qwAjyRhCq2TOAh0EDRNgYaSlbIXX/zp38FpK/9DMbtH14vVvG6FXog75
 HBoOzsFNBF3VOUgBEACbvyZOfLjgfB0hg0rhlAfpTmnFwm1TjkssGZKvgMr/t6v1yGm8nmmD
 MIa4jblx41MSDkUKFhyB80wqrAIB6SRX0h6DOLpQrjjxbV46nxB5ANLqwektI57yenr/O+ZS
 +GIuiSTu1kGEbP5ezmpCYk9dxqDsAyJ+4Rx/zxlKkKGZQHdZ+UlXYOnEXexKifkTDaLne6Zc
 up1EgkTDVmzam4MloyrA/fAjIx2t90gfVkEEkMhZX/nc/naYq1hDQqGN778CiWkqX3qimLqj
 1UsZ6qSl6qsozZxvVuOjlmafiVeXo28lEf9lPrzMG04pS3CFKU4HZsTwgOidBkI5ijbDSimI
 CDJ+luKPy6IjuyIETptbHZ9CmyaLgmtkGaENPqf+5iV4ZbQNFxmYTZSN56Q9ZS6Y3XeNpVm6
 FOFXrlKeFTTlyFlPy9TWcBMDCKsxV5eB5kYvDGGxx26Tec1vlVKxX3kQz8o62KWsfr1kvpeu
 fDzx/rFpoY91XJSKAFNZz99xa7DX6eQYkM2qN9K8HuJ7XXhHTxDbxpi3wsIlFdgzVa5iWhNw
 iFFJdSiEaAeaHu6yXjr39FrkIVoyFPfIJVyK4d1mHe77H47WxFw6FoVbcGTEoTL6e3HDwntn
 OGAU6CLYcaQ4aAz1HTcDrLBzSw/BuCSAXscIuKuyE/ZT+rFbLcLwOQARAQABwsF2BBgBCAAg
 FiEE5rmSGMDywyUcLDoX2RQLslYTAvEFAl3VOUgCGwwACgkQ2RQLslYTAvG11w/+Mcn28jxp
 0WLUdChZQoJBtl1nlkkdrIUojNT2RkT8UfPPMwNlgWBwJOzaSZRXIaWhK1elnRa10IwwHfWM
 GhB7nH0u0gIcSKnSKs1ebzRazI8IQdTfDH3VCQ6YMl+2bpPz4XeWqGVzcLAkamg9jsBWV6/N
 c0l8BNlHT5iH02E43lbDgCOxme2pArETyuuJ4tF36F7ntl1Eq1FE0Ypk5LjB602Gh2N+eOGv
 hnbkECywPmr7Hi5o7yh8bFOM52tKdGG+HM8KCY/sEpFRkDTA28XGNugjDyttOI4UZvURuvO6
 quuvdYW4rgLVgAXgLJdQEvpnUu2j/+LjjOJBQr12ICB8T/waFc/QmUzBFQGVc20SsmAi1H9c
 C4XB87oE4jjc/X1jASy7JCr6u5tbZa+tZjYGPZ1cMApTFLhO4tR/a/9v1Fy3fqWPNs3F4Ra3
 5irgg5jpAecT7DjFUCR/CNP5W6nywKn7MUm/19VSmj9uN484vg8w/XL49iung+Y+ZHCiSUGn
 LV6nybxdRG/jp8ZQdQQixPA9azZDzuTu+NjKtzIA5qtfZfmm8xC+kAwAMZ/ZnfCsKwN0bbnD
 YfO3B5Q131ASmu0kbwY03Mw4PhxDzZNrt4a89Y95dq5YkMtVH2Me1ZP063cFCCYCkvEAK/C8
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <300b6fb4ba2c9399297b4bd85cbb3bc14f08f6b7.1783097764.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9620-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[suse.com,kernel.org,vger.kernel.org,broadcom.com,lists.infradead.org,raspberrypi.com,suse.de,mess.org,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:andrea.porta@suse.com,m:ukleinek@kernel.org,m:linux-pwm@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:devicetree@vger.kernel.org,m:linux-rpi-kernel@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:naush@raspberrypi.com,m:svarbanov@suse.de,m:sean@mess.org,m:julianbraha@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mbrugger@suse.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbrugger@suse.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:from_mime,suse.com:email,suse.com:mid,suse.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34C4D71B79C



On 03/07/2026 19:05, Andrea della Porta wrote:
> From: Stanimir Varbanov <svarbanov@suse.de>
> 
> The RP1 chipset used on the Raspberry Pi 5 features an integrated
> PWM controller to drive the cooling fan.
> 
> Add the corresponding DT node for this PWM controller.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Co-developed-by: Andrea della Porta <andrea.porta@suse.com>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts | 12 ++++++++++++
>   arch/arm64/boot/dts/broadcom/rp1-common.dtsi     |  9 +++++++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
> index 0fc57e72632ed..748be8f1ee9e2 100644
> --- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
> +++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
> @@ -64,6 +64,12 @@ phy1: ethernet-phy@1 {
>   };
>   
>   &rp1_gpio {
> +	fan_pwm_default_state: fan-pwm-default-state {
> +		function = "pwm1";
> +		pins = "gpio45";
> +		bias-pull-down;
> +	};
> +
>   	usb_vbus_default_state: usb-vbus-default-state {
>   		function = "vbus1";
>   		groups = "vbus1";
> @@ -94,6 +100,12 @@ &rp1_i2c6 {
>   	pinctrl-names = "default";
>   };
>   
> +&rp1_pwm1 {
> +	pinctrl-0 = <&fan_pwm_default_state>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
>   &rp1_usb0 {
>   	pinctrl-0 = <&usb_vbus_default_state>;
>   	pinctrl-names = "default";
> diff --git a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
> index 16f5359395835..df4c2d09c8d34 100644
> --- a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
> @@ -99,7 +99,16 @@ rp1_i2c6: i2c@40088000 {
>   		clocks = <&rp1_clocks RP1_CLK_SYS>;
>   		i2c-scl-rising-time-ns = <65>;
>   		i2c-scl-falling-time-ns = <100>;
> +		status = "disabled";
> +	};
>   
> +	rp1_pwm1: pwm@4009c000 {
> +		compatible = "raspberrypi,rp1-pwm";
> +		reg = <0x00 0x4009c000  0x0 0x100>;
> +		clocks = <&rp1_clocks RP1_CLK_PWM1>;
> +		assigned-clocks = <&rp1_clocks RP1_CLK_PWM1>;
> +		assigned-clock-rates = <50000000>;
> +		#pwm-cells = <3>;
>   		status = "disabled";
>   	};
>   


