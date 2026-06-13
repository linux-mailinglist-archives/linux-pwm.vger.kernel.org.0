Return-Path: <linux-pwm+bounces-9288-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UtY6H9BMLWrNegQAu9opvQ
	(envelope-from <linux-pwm+bounces-9288-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Jun 2026 14:28:00 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE8767E877
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Jun 2026 14:27:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jAoygz65;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9288-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9288-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3EBA30182B3
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Jun 2026 12:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88271386556;
	Sat, 13 Jun 2026 12:27:57 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C4D3E173A
	for <linux-pwm@vger.kernel.org>; Sat, 13 Jun 2026 12:27:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781353677; cv=none; b=Cv7tJqt9LPduUaBoyiJAjzxM5LiV5jW/Xfx1hftbF3AsHnxiwJi6E0w9Jcy30rUmBTgrRpVA6q7AhaFrtbGEbz8V7lx/sVBQFDoTDTf7qYSuA+sqQ1QEjDNE4XFtLON0UEOTfWtpigugzRrYBe/GwPD9fPN+IWSB4QJqFwTy9/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781353677; c=relaxed/simple;
	bh=wyBnsEG/WaX5EAHS7GvLfH6Gnbnh7zVFPoJRpUZUsFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FnVRNCBncLgqCYWS7xzuVjKizY8gvy579fJXbYcp3IkwarQf9Fykj0jCIAwbi2hd/52vwDyuOx9gAgBA69mKlwXcYVao6ls/Pl6AF0bbiUVBZnSaLkrMkuH6Yj8khude0VqUqrjHRx5bHnJDUVMX3twILLDhNgaehCfklzjEDyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAoygz65; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-491b390f9e9so11514555e9.0
        for <linux-pwm@vger.kernel.org>; Sat, 13 Jun 2026 05:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781353672; x=1781958472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=wmpCRbwKcDT9ljmI6gDYWNgoa8Oz6gngcqL23DluDRY=;
        b=jAoygz65cM6S2sxyLIdQqb7ABrNmv5VDOfcEpA8RZ4hxGICQJqb7g9Oaxk4M0up1nQ
         Re4lJmxKUhbDS59H1Lp4Fx+v6LMYtHTZfY/Rajt/j3TQtMtOI7DIR0Rj1CwB6ecqe0C0
         N2/VIVLrR8jhfc+oPy9ldfGVuzJEBSHa3yFk3hDYySDdS8lYC3Hqp7omW47foFVhBFtp
         ZaXofMlX5JLIsCtaysxr3rCQ7q9FdtPMyEI/2EsYbAppNNOVbylNHHLNz1iPHIlrfoOy
         QQmQrRRrZpNvgtqzAEFp896LwVWc7N/6Rb0H0sMuhUBxHwVa3FAYIxqXGbd04gKR5Dgc
         Of8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781353672; x=1781958472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmpCRbwKcDT9ljmI6gDYWNgoa8Oz6gngcqL23DluDRY=;
        b=pbyGankkqbVIew9OOfq+zmwzpLdu7sp5uykTH+5/vwkFXs2Nhp7vMMC/X3m7Njz6RF
         2EWAsN2/z2RIEmcW4E/3Y2e9woMbuMFcbuUTjja7CHYLWk3PivJqknWJ0gxXVth3ofEq
         k+AYOa3TSw2ZqvlRq8FhXg+R24UMDhkBwgQBkij59ZKVTQM4dtKjJ+yeU7btFJY2FoX2
         McGF9fphiXBtSd2csbWC8W3TXbY+hqkNhnF2uVQIaAnlOBixOTuj+3aXElc1sQfJnqC+
         E+5tTT2Ndx39ZS8yi1S/pxCNs2c062XDca13ohvCHPM5yl2VUjqJfwRNFh7Lc6q7Je9R
         6WJg==
X-Forwarded-Encrypted: i=1; AFNElJ8C2aHa8J+B7udipbGe0yK3K91A0iHK9xv6G5QlKu1uiKfVb6htLff2lYD5XHPSonMN8orsr/uoFeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPUujrsNBAMqcX04c4S0+4G9/qPPSpoFES52qxWyH+glztf7+B
	p54Y4BuliKR8SYCiOfbe5rUslqIo45Oppnl/PglGj83JQYEPSLFQgOBt
X-Gm-Gg: Acq92OF23EIUo59Sug8rUb74ZCXKcLfVryemt4DvXOxazyoDQRKiPxMNmlucerdbKG+
	9QonUrddMYb6fYWb5rTxrktdZgV5dsxi0K3hBW+BYfSpT2yEc60ZJQMjsVNBaV+PSJ78KyQ4vz+
	WwNvDNf+0qUWGGJ4+mGAwlZKjNkswy2TdAOstItrcJb8CRK0P2Y/Ne20QGdEk4DJGk6E9n8mfGT
	mfMKbMYxKBmJcpX0790ysAp3+eFypXeQVhvT/cWplwXLIVQ/6WKfwPUhYnblJcrXoCdQEw6yk9I
	3RtOnk8fmfvaR1SGcanRXQZMWcjXx1a0vn8vXOtiVxoLstMyikb3w7opNF3WQbxH4RAOYDh6dP+
	5q0narh8BnjV+2TvP26/qE8x+kpVEIDEC7kfBJJWbu7xYajV4poDVNSMM2n2zvlPa146Bm4UJpU
	6kd4spsWqZnQMoNp7Wa/GpOYJ91rlOSernoOb/A6W2ItOecT9WIE9O52Cfw8rxO3/2HPuIwtiEA
	M5IP2QpmvoE+3e3kRV9J+kz08YyeQ==
X-Received: by 2002:a05:600c:1d11:b0:492:1e36:552c with SMTP id 5b1f17b1804b1-4921e365572mr47345445e9.37.1781353672276;
        Sat, 13 Jun 2026 05:27:52 -0700 (PDT)
Received: from [10.128.10.215] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492202e5cbasm62586845e9.2.2026.06.13.05.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 05:27:51 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <0b6a7f41-b753-48dc-b46e-77aaf0e999f4@gmail.com>
Date: Sat, 13 Jun 2026 13:27:49 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] pwm: rp1: Add RP1 PWM controller driver
To: Andrea della Porta <andrea.porta@suse.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Naushir Patuck <naush@raspberrypi.com>,
 Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com
References: <cover.1780670224.git.andrea.porta@suse.com>
 <f8dd46a553351adaf9d29fbba9f98e803b672fe7.1780670224.git.andrea.porta@suse.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <f8dd46a553351adaf9d29fbba9f98e803b672fe7.1780670224.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-9288-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[julianbraha@gmail.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrea.porta@suse.com,m:ukleinek@kernel.org,m:linux-pwm@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:devicetree@vger.kernel.org,m:linux-rpi-kernel@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:naush@raspberrypi.com,m:svarbanov@suse.de,m:mbrugger@suse.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[julianbraha@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECE8767E877

On 6/12/26 15:01, Andrea della Porta wrote:

> +config PWM_RASPBERRYPI_RP1
> +	tristate "RP1 PWM support"
> +	depends on MISC_RP1 || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	select REGMAP_MMIO
> +	select MFD_SYSCON
> +	help
> +	  PWM framework driver for Raspberry Pi RP1 controller.
> +

Hi Andrea,

Selecting REGMAP_MMIO is unnecessary here since you're already selecting
MFD_SYSCON.

- Julian Braha

