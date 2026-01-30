Return-Path: <linux-pwm+bounces-8013-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFYCLQwWfGkeKgIAu9opvQ
	(envelope-from <linux-pwm+bounces-8013-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 03:23:08 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9EBB6621
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 03:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2AA7130058F7
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 02:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70922737EE;
	Fri, 30 Jan 2026 02:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="MXnSDA4n"
X-Original-To: linux-pwm@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4016332A3D7
	for <linux-pwm@vger.kernel.org>; Fri, 30 Jan 2026 02:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769739784; cv=none; b=EUYZ78ujWFIsm6IfBX7nEHx04OBUau3dFP/7gCiilRNNHC5y/JX7DvECtOJ4aHVNVzmIU1a+/7bA25Yu9U3fsViMMR9cRWgH5u66VHd8211rQTKJvXptHpVNTDN82e3PoSCGrHG+WifXQo5f+KwUiuOgfeh236qVmB3Fd7etj+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769739784; c=relaxed/simple;
	bh=J/BN6oENb0WwKgg08zPz94VDKZv1XTnVegd5k04rzCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jc2UgdMFgwEz7Ew14HAhYTXjwOm6XlbampKH9UcPrLsJL1bydiaF88YxoiQvE4v2ZRfDr7YpkPc9Bil5B3JnbBJmjLChWxWr1SxiOzOzSKPuUQNaRFwhPHmabdn/D4lBiUD0n0RjDTbQN6RxmKvWwg+/36lNTZmIk0Ji43vXd9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=MXnSDA4n; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60U2MtXmA079784, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769739775; bh=J/BN6oENb0WwKgg08zPz94VDKZv1XTnVegd5k04rzCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=MXnSDA4nzYStyxWAT+5kCUW6IsKVWXW/DWLWXD+iY/KkT3nDk3zItXL8CH5yfWJMF
	 9Aeq42Luyxx/pH6numxJhyIrMZaIb6y87di6YQXVnr8qCCbWx/OtaPBiSOsd1D4Eud
	 SAcT+i2Txf/vMPUI5o6GgrgKa9XIRcflgJE31jcsJrKQDDEjtrBsk9y83Ax3XjSAFt
	 awKSFNOYHgcwfc887d6X/cFJzo7XwgT7QaXQm1Aox7VRsdCY3R5f7T52F2DOthYAKW
	 ilIYvtjTNSo1IFOyWHfjCp684pjIuRXAhLSrVX2yKeElvnDM6+a4E3TF6uutw81p4m
	 CuH8UCS7FPr2g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60U2MtXmA079784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 10:22:55 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 30 Jan 2026 10:22:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 30 Jan 2026 10:22:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Fri, 30 Jan 2026 10:22:55 +0800
From: =?utf-8?B?WXUtQ2h1biBMaW4gW+ael+elkOWQm10=?= <eleanor.lin@realtek.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>,
        Linus Walleij
	<linusw@kernel.org>
CC: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "brgl@kernel.org"
	<brgl@kernel.org>,
        =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?=
	<james.tai@realtek.com>,
        =?utf-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?=
	<cy.huang@realtek.com>,
        =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?=
	<stanley_chang@realtek.com>,
        =?utf-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?=
	<tychang@realtek.com>
Subject: RE: [PATCH 5/8] dt-bindings: pinctrl: realtek: add RTD1625 pinctrl
 binding
Thread-Topic: [PATCH 5/8] dt-bindings: pinctrl: realtek: add RTD1625 pinctrl
 binding
Thread-Index: AQHckAe6vQgfzNK4QkiO7051ODDQUrVm/k4AgAFyaYCAAYyn8A==
Date: Fri, 30 Jan 2026 02:22:55 +0000
Message-ID: <39b74303c3674f5ea7bd4efb5f2073e0@realtek.com>
References: <20260128033936.27642-1-eleanor.lin@realtek.com>
 <20260128033936.27642-6-eleanor.lin@realtek.com>
 <CAD++jL=445wx467ZKE3-qm_BaVzKYXE-7zmReTFZA0KUAaSNyw@mail.gmail.com>
 <hqxvkj5iog5g6bdnwykctkc74zcynnf43zssu76xp5d5lyiz4o@tf4izpf3wapk>
In-Reply-To: <hqxvkj5iog5g6bdnwykctkc74zcynnf43zssu76xp5d5lyiz4o@tf4izpf3wapk>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8013-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:mid,realtek.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eleanor.lin@realtek.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4D9EBB6621
X-Rspamd-Action: no action

PiBIZWxsbyBMaW51cywNCj4gDQo+IE9uIFdlZCwgSmFuIDI4LCAyMDI2IGF0IDAxOjMzOjAwUE0g
KzAxMDAsIExpbnVzIFdhbGxlaWogd3JvdGU6DQo+ID4gW1V3ZSwgY2FuIHlvdSBjaGVjayB0aGlz
IGEgYml0IGRvd24hXQ0KPg0KPiBIbW0sIEknZCBsaWtlIHRvIHNlZSB0aGUgd2hvbGUgcGF0Y2gg
Zm9yIHRoYXQsIGJ1dCBJIGRvbid0IGZpbmQgaXQgb24gbG9yZS5rZXJuZWwub3JnIChodHRwczov
L2xvcmUua2VybmVsLj4gb3JnL2FsbC9DQUQrK2pMPTQ0NXd4NDY3WktFMy1xbV9CYVZ6S1lYRS03
em1SZVRGWkEwS1VBYVNOeXdAbWFpbC5nbWFpbC5jb20vI3JlbGF0ZWQpLg0KPiBNYXliZSB0aGUg
b3JpZ2luYWwgcGF0Y2ggaXMgc3RpbGwgaW4gbW9kZXJhdGlvbiBvciB3YXMga2lsbGVkIGJ5IGEg
c3BhbSBmaWx0ZXI/DQo+DQo+IEJlc3QgcmVnYXJkcw0KPiBVd2UNCg0KSGkgVXdlLA0KDQpJdCB3
YXMgbXkgZmF1bHQgZm9yIG1pc3NpbmcgdGhlIG1haWxpbmcgbGlzdCB3aGVuIHNlbmRpbmcgdjEu
DQoNClNpbmNlIEkgaGF2ZSByZWNlaXZlZCBzZXZlcmFsIGNvbW1lbnRzIGZyb20gTGludXMgV2Fs
bGVpaiBhbmQgQmFydG9zeg0KR29sYXN6ZXdza2ksIEkgbmVlZCBzb21lIHRpbWUgdG8gZGlzY3Vz
cyB0aGUgY2hhbmdlcyB3aXRoIG15IGNvbGxlYWd1ZXMNCmJlZm9yZSBJIGNhbiBzZW5kIG91dCBh
IHByb3BlciB2Mi4NCg0KSSBhbSBhZnJhaWQgdGhhdCByZXNlbmRpbmcgdjEgbWlnaHQgYm90aGVy
IG90aGVyIG1haW50YWluZXJzLg0KVGhlcmVmb3JlLCBwbGVhc2UgYWxsb3cgbWUgdG8gc2VuZCB5
b3UgdGhlIGZ1bGwgcGF0Y2ggc2VyaWVzIHByaXZhdGVseS4NCg0KU29ycnkgZm9yIHRoZSBpbmNv
bnZlbmllbmNlLg0KDQpCZXN0IHJlZ2FyZHMsDQpZdS1DaHVuDQo=

