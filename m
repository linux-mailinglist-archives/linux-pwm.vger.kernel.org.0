Return-Path: <linux-pwm+bounces-9669-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qvaeH7yaT2pLkwIAu9opvQ
	(envelope-from <linux-pwm+bounces-9669-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 14:57:32 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C07A873148A
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 14:57:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jannau.net header.s=fm3 header.b=MAloY8DL;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=BOpapHeU;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9669-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9669-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4CA1303514E
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2026 12:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF94A231C91;
	Thu,  9 Jul 2026 12:57:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBEE1BC2A;
	Thu,  9 Jul 2026 12:57:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601848; cv=none; b=r2qktTWl38kcMx5xOAmrAubDghF2qbH8oFQxZqDir8KSsIl1Dc4fiAPPD7Nc9+a5wdFNdZ9U/akWh0uefLEmzWOzQmo/cyekN0eofhcCoAmaNI4K1jbQB8/rfllRlddA16wO2Dbzpr7LQSw4TDOiUWm1nZ42VKofPV6k5nSfyqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601848; c=relaxed/simple;
	bh=BWjjVlBgB0OZCHwWPWKWyCuvf2niD2g3FNGw6Y2h5Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRIlJkJMvOgTRb1DbXHcw0lFDFxagsXi4LYElk2/Jb2nRNBGr+GbdpG2/LAQsRdn4E5BTVTnBfWp1D3bfvwBEUc3o5SHw/GHoe5TnLAryN+5ghuN8ssdoP/mEnzsDJcBN3EpX+av5aKfSr1UyuLXv7Hzhrxl4slBd2qRVEMNmAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=MAloY8DL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BOpapHeU; arc=none smtp.client-ip=103.168.172.136
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 227071380125;
	Thu,  9 Jul 2026 08:57:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 09 Jul 2026 08:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1783601846; x=1783609046; bh=9vhPsjm8y4
	AkFo9XBzDdQLzSSMj8DyvQj89Hj7A1Pc8=; b=MAloY8DLGI2kz9gtU8Cbcceoq5
	xslgijqbYm3Bjy83+Nt4KjHGuTuPnPr2qxCZ8GDlXIEuaw+woqrfK6UUqGZh1A+T
	BiIVm9xHpetpymZv7fIoLMqGH3ADNxyegpb35XJAPWOF2zYbM4dX18YeRCWB1n9y
	lWpux5Vz+b0CDHMJ9DrBZDgG74aqTqZmDIm0fbgXgdoo8pl2Ud0LHIzWUnAzMn59
	ScvrzfqCRHsIc9BYxN6U6IDF/XDQv0VslcAz3mWys2USLA2VO1KPjfDKZrFdWceG
	D5z1nX9zUQj/yc8GgIvXsvjyHA9dpVeygH5Lm4nhKSOECzN1ivF/FBfFjGhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783601846; x=1783609046; bh=9vhPsjm8y4AkFo9XBzDdQLzSSMj8DyvQj89
	Hj7A1Pc8=; b=BOpapHeUioU1QD0HMwYKofiTtUTfX0HnywsT60OFSMb5R9K5yU5
	zo+CuiqGuZ7BNFPkOVKvc1GYguoxN+uMZvkLIIUlb1LEp39UYUEC10GFlbkGM6JM
	5h5a3Xz4Wp55jjbf10jGKdWmGvPGPGwsE44cadjFaE9ghzA2NKyve/FIacZR4oeA
	xTrvg179+1gYtHH2LtC9EoDpkA4kzIatB6bkTS/1LUXvpZDrK6H7NpVGSO2i1OFZ
	d+jlyDZrbcmIkGiSzzkwHghYbgMCxlF22OmIuu1mwIiDKtm4/+1QDL9YECLOGAtF
	WpYf2stYybCYgWtU0wnvF1br3gk65eCXDxA==
X-ME-Sender: <xms:tZpPalyUxlEtKfJmWVuSbZ19aG-se8S4JznXv-r1F-iXgmpE7aSWuQ>
    <xme:tZpPaicq4N3L7doyS07eV-TxfoCTqg49Hl4hmfwq4K2V77l29vDUrLea_aG4M0Swh
    9oan9H4Yc_C_GX_wKhKNVUfn2BKIgik6T2uUL5_gUbyzwia6h2E1tU>
X-ME-Received: <xmr:tZpPaj11_INdcuGRsXGeE3F2bGT_ienNJDlrsLo9v4N1K5nA1u_czlRPm9UIJ1UYFDVB1tvBJyQJ7lhXGgfB-F22mpA4i1jMTcE>
X-ME-Proxy-Cause: dmFkZTE/p7RSt2I/QsWrMFYlaFvbRsgvhyTlO9VqpiSxDsbzxxrJLY0xbb0cTdfhO1lPCK
    P4FWs4VOcnWTMkPjVIv5Ss/Q9Nr2oVw0eZlyzvJ0DYOdAVWIft+dr2F3bnvDD/1u1SuylT
    MkzsRt5fU4OF31OVwoiqKwjveYdn18ABrjb7aK233MoArvtelMz/AsJQKaXOQdHyoLmFqa
    BbkVFXO6yCaWrIV4dxPiS6SrWlTSOOk4TszqxqGbTFLGzul4h+Ko/vSl6u1o4IYNgMPBqH
    XrOgKgtgbMrqKLDsb/9LS3PRr8m8w4HEHYUYzP9Gd4qO1nWHxvjcp1a5IMBT9tN4yNuZuJ
    Vgt0t4l/peNcMKXSzCVkZMXc2sJina6RQ4CQ9CyxiOg6DIuMuTau11llUiCTPR+pa1eGSW
    zap7sLHM6lzdi85fWJZAIGlS2CBIGg15XqHaw2qrBIh+1us4yvFVXwvfVVaOZpck9wM5w/
    pbpfFEl2S2IHHIIEEAVlfbOpSrdSc02pU0QIeropFyITeLA8zYjV0DkxAO8yb085XupfQ6
    iFYqlvOUROkW5dIJLDQzx74YzUI+dUlTrbhVgXmB4PN5OoHQcCpVYhq1zSa6bz4ytStg+d
    8awNAmLFMv9WiBezjFJRIfw99f+ABSAauuFeIqAwFStVPdL7EaOvwaB2KXvw
X-ME-Proxy: <xmx:tZpPajvA1xPOoE-IQaiwOeZisrKb_Bi7TfPJi_LF5Qo-r69J0feHyw>
    <xmx:tZpPan_AtxCOyMDBrlfwWx0oagmcYsNtG6X-I2G9YnOH2djnjQQrbA>
    <xmx:tZpPavS2VJK0xY9-goalKOX4MaMoGgASGCDjdwqHQqkrNa4tADHY7A>
    <xmx:tZpPalC6W3m41fs1Vm0ZrEcYIwRzISZ1LmffoAWgLcwHi7IU-uER8Q>
    <xmx:tppPahHuOHhn8ZWqEIOtkdrrA7AGKVxibdrtzF2p9ZFEwZDDwg23ZfXW>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 08:57:24 -0400 (EDT)
Date: Thu, 9 Jul 2026 14:57:23 +0200
From: Janne Grunau <j@jannau.net>
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linusw@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 00/11] Initial Apple M3 Pro, Max and Ultra device trees
Message-ID: <20260709125723.GA1985988@robin.jannau.net>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9669-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sven@kernel.org,m:neal@gompa.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:linusw@kernel.org,m:kettenis@openbsd.org,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-watchdog@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	DMARC_NA(0.00)[jannau.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,jannau.net:from_mime,jannau.net:dkim,robin.jannau.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C07A873148A

On Thu, Jul 09, 2026 at 09:30:46AM +0200, Janne Grunau wrote:
> This series adds device trees for Apple silicon devices with M3 Pro, Max
> and Ultra SoCs. The M3 generation has fewer devices than their M1 and M2
> predecessors. The only non-laptop device is the M3 Ultra Mac Studio. The
> Laptops are the known 14 and 16-inch Macbook Pros now with M3 Pro and
> M3 Max SoCs. The M3 Max variant with fewer CPU and GPU cores has
> additionally only a 384-bit wide memory bus instead of 512-bit of the
> full M3 Max. It has a separate identifier (T6034) and so there are six
> laptop device trees.
> Another difference to M1 and M2 Pro/Max/Ultra is that the M3 Pro is
> distinct SoC design and not a smaller M3 Max. For this reason both M3
> Max variants and the M3 Ultra will use "apple,t6030" as compatible
> prefix. In the M1 and M2 generations Pro, Max and Ultra SoCs shared
> "apple,t6000" / "apple,t6020" as common prefix. There is currently no
> known difference but M3 Pro and M3 Max are not as closely related as
> previously.
> 
> This series adds the same level of hardware as the base M3 (T8122) has
> in v7.2-rc1. This includes CPU cores, interrupt controller, power
> states, watchdog, serial, pin controller, i2c and the boot framebuffer.
> This is intended as base so that support for additional hardware can be
> added to all M3 based devices at the same time.
> 
> Merge strategy:
> Since the dt-binding add new compatible strings without driver changes
> it would be preferred if the whole [1] series would be merged through
> apple-soc/arm-soc. This will help ensuring a warning free
> `make dtbs_check` for followup series with additional M3* hardware
> support I hope to send for this cycle.
> 
> This series will conflict with the M4 series [3] sent A couple of days
> ago. I would prefer if this could be merged first (in order of SoC
> release).
> 
> [1]: I see that the M4 watchdog change was already picked up by Guenter
>      in [2] 
> 
> Link: https://lore.kernel.org/asahi/a03c19ee-cf74-4f26-826d-f2bfb816fb3f@roeck-us.net/ [2]
> Link: https://lore.kernel.org/asahi/20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev/ [3]

I fixed the legitimate issues poited out by sashiko locally and will
send a v2 in the next days. From the v2 changelog:

- fix serial0 unit address in t6030.dtsi, drop erroneously added 0
- Fix device node reference in pinctrl_{nub,aop} gpio-ranges in t6030.dtsi
- fix i2c6 unit address in t6031-die0.dtsi
- fix cpu_p25 reg value in t6032.dtsi
- drop unnecessary aic interrupt-controller from t6032.dtsi
- drop "label" from keyboard pwm led node
- fix copy-n-pasted pinctrl in compatible strings in the apple,s5l-fpwm
  dt-binding commit message
- fix yamllint errors in apple.yaml and fix warnings in newly added
  lines

Janne

