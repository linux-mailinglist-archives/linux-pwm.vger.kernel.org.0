Return-Path: <linux-pwm+bounces-8158-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBxEGF7BnmnsXAQAu9opvQ
	(envelope-from <linux-pwm+bounces-8158-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Feb 2026 10:31:10 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D2519504D
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Feb 2026 10:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85F163037E50
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Feb 2026 09:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512D02EF652;
	Wed, 25 Feb 2026 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="RXBKyMiJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC64329E76
	for <linux-pwm@vger.kernel.org>; Wed, 25 Feb 2026 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011835; cv=none; b=AK6UWRaYRGNFmqv4E/e/W8o/LTR6xpinEkFG30q6/DPx9n1f6I4DmQkdQP0XqaO4YU680yBjST0CVRvErTyecG6c6+8AY0Zr6mv4jWAdoDQADuU2CyfdajFuCCwJKzJrZUgxwEmysZ69u0LPuKtYE9PYZ8Te4/LY1oxwvfEUiks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011835; c=relaxed/simple;
	bh=FQN81HDaevwTJmEi80XAZqDVT254JpIoGiVgmkZx4kA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q25pUfOVJ7OApRXglyzp3m+th/IUNf7/rkDRt9obsVB+WeSICVmNMHU35RPih+0+hwunfGxb4ETsnsA4by4OJTNYRk8xTBwyLm8I+yj0s+dEgv4505Lg0gV7dyDYyvvL+5Kk9acu3AfjlXdSJNIMgz00JMzyRQw39HwDTScMNcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=RXBKyMiJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61P9UPcvC803193, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1772011825; bh=FQN81HDaevwTJmEi80XAZqDVT254JpIoGiVgmkZx4kA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=RXBKyMiJSODj/hh0h3dCAoSi2zQY76uYvGTXwCEPOPvMhLMwMsFTg0+uXCucQuIt7
	 JEJRSosB621EieebG3kzGMMQM8uZfcbpFASHQTMafh54BgaVgLrg/i/Ndl18vIsI4H
	 bpDU5pHOjGAyyl/aC5bHyk0ji7cwPGjKVp9QC8Z/ikjPy/ePAOIYiamoIvwWiMvTCF
	 uA0kCaKvEqyefeghUSLSaTaKDkE/82hU4ez3TWjKrqgWrsFOsD8JlhAg3FvFwY0Ook
	 0DgB5YVfBNbX3XL+Zd+ULaBFV+BHupBlgK03HrtJpRwcFnuFnlgRC0fT7B3G+EL0cg
	 mbgSx8yjYTtRw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61P9UPcvC803193
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 17:30:25 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 25 Feb 2026 17:30:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 25 Feb 2026 17:30:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Wed, 25 Feb 2026 17:30:25 +0800
From: =?utf-8?B?WXUtQ2h1biBMaW4gW+ael+elkOWQm10=?= <eleanor.lin@realtek.com>
To: Linus Walleij <linusw@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<ukleinek@kernel.org>,
        "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "brgl@kernel.org" <brgl@kernel.org>,
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
Thread-Index: AQHckAe6vQgfzNK4QkiO7051ODDQUrVm/k4AgCxULmA=
Date: Wed, 25 Feb 2026 09:30:25 +0000
Message-ID: <d5be357c14b84155adfa8a9f00a64d83@realtek.com>
References: <20260128033936.27642-1-eleanor.lin@realtek.com>
 <20260128033936.27642-6-eleanor.lin@realtek.com>
 <CAD++jL=445wx467ZKE3-qm_BaVzKYXE-7zmReTFZA0KUAaSNyw@mail.gmail.com>
In-Reply-To: <CAD++jL=445wx467ZKE3-qm_BaVzKYXE-7zmReTFZA0KUAaSNyw@mail.gmail.com>
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
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8158-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eleanor.lin@realtek.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D4D2519504D
X-Rspamd-Action: no action

SGkgTGludXMsDQoNClNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseS4NCg0KPiBIaSBZdS1DaHVuLA0K
PiANCj4gdGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiANCj4gW1V3ZSwgY2FuIHlvdSBjaGVjayB0
aGlzIGEgYml0IGRvd24hXQ0KPiANCj4gT24gV2VkLCBKYW4gMjgsIDIwMjYgYXQgNDozOeKAr0FN
IFl1LUNodW4gTGluIDxlbGVhbm9yLmxpbkByZWFsdGVrLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+
IEZyb206IFR6dXlpIENoYW5nIDx0eWNoYW5nQHJlYWx0ZWsuY29tPg0KPiA+DQo+ID4gQWRkIGRl
dmljZSB0cmVlIGJpbmRpbmdzIGZvciBSVEQxNjI1Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
VHp1eWkgQ2hhbmcgPHR5Y2hhbmdAcmVhbHRlay5jb20+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBZ
dS1DaHVuIExpbiA8ZWxlYW5vci5saW5AcmVhbHRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
WXUtQ2h1biBMaW4gPGVsZWFub3IubGluQHJlYWx0ZWsuY29tPg0KPiANCj4gT3ZlcmFsbCB0aGlz
IGxvb2tzIGdvb2QhDQo+IA0KPiA+ICsgICAgICBwb3dlci1zb3VyY2U6DQo+ID4gKyAgICAgICAg
ZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgICAgIFZhbGlkIGFyZ3VtZW50cyBhcmUgZGVzY3Jp
YmVkIGFzIGJlbG93Og0KPiA+ICsgICAgICAgICAgMDogcG93ZXIgc3VwcGx5IG9mIDEuOFYNCj4g
PiArICAgICAgICAgIDE6IHBvd2VyIHN1cHBseSBvZiAzLjNWDQo+ID4gKyAgICAgICAgZW51bTog
WzAsIDFdDQo+IA0KPiBPSy4uLg0KPiANCj4gPiArICAgICAgc2xldy1yYXRlOg0KPiA+ICsgICAg
ICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gKyAgICAgICAgICBWYWxpZCBhcmd1bWVudHMgYXJlIGRl
c2NyaWJlZCBhcyBiZWxvdzoNCj4gPiArICAgICAgICAgICAgMDogfjFucyBmYWxsaW5nIHRpbWUN
Cj4gPiArICAgICAgICAgICAgMTogfjEwbnMgZmFsbGluZyB0aW1lDQo+ID4gKyAgICAgICAgICAg
IDI6IH4yMG5zIGZhbGxpbmcgdGltZQ0KPiA+ICsgICAgICAgICAgICAzOiB+MzBucyBmYWxsaW5n
IHRpbWUNCj4gPiArICAgICAgICBlbnVtOiBbMCwgMSwgMiwgM10NCj4gDQo+IFNsZXcgcmF0ZSBp
cyB1c3VhbGx5IHNvbWV0aGluZyBsaWtlIHZvbHRzL3NlY29uZCBpbiBTSSB1bml0cywgSSB3b3Vs
ZCBleHBlY3QgdGhhdA0KPiB0aGlzIGRpZmZlcnMgZGVwZW5kaW5nIG9uIHdoaWNoIHBvd2VyLXNv
dXJjZSBpcyBzZWxlY3RlZD8NCj4gSS5lLiBhcmUgdGhlc2UgdmFsdWVzIGZvciAxLjhWIG9yIDMu
M1Y/DQo+IA0KDQpUaGlzIHNsZXctcmF0ZSBjb25maWd1cmF0aW9uIGlzIHNwZWNpZmljYWxseSBh
cHBsaWVkIHRvIHRoZSBIRE1JIEkyQyBwaW5zIG9ubHkuDQpUaGVzZSBwaW5zIG9wZXJhdGUgYXQg
MS44Vi4NCg0KPiA+ICsgICAgICByZWFsdGVrLGRyaXZlLXN0cmVuZ3RoLXA6DQo+ID4gKyAgICAg
ICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgICAgIFNvbWUgb2YgcGlucyBjYW4gYmUgZHJp
dmVuIHVzaW5nIHRoZSBQLU1PUyBhbmQgTi1NT1MNCj4gdHJhbnNpc3RvciB0bw0KPiA+ICsgICAg
ICAgICAgYWNoaWV2ZSBmaW5lciBhZGp1c3RtZW50cy4NCj4gDQo+IEZpbmVyIGNvbXBhcmVkIHRv
IHdoYXQ/IENvbXBhcmVkIHRvIHRoZSBvdmVyYWxsIHNldHRpbmcgZm9yIHNsZXctcmF0ZSBvcg0K
PiBkcml2ZS1zdHJlbmd0aCwgb3IgYm90aD8NCj4gDQoNCkl0IHByb3ZpZGVzIGZpbmVyIHBhZCBk
cml2aW5nIGNhcGFiaWxpdHkgY29tcGFyZWQgdG8gdGhlIGdlbmVyaWMgZHJpdmUtc3RyZW5ndGgN
CnByb3BlcnR5LiBUaGlzIHByb3BlcnR5IGFsbG93cyBmb3IgaGlnaGVyIHJlc29sdXRpb24gY29u
dHJvbC4NCg0KPiA+IFRoZSBibG9jay1kaWFncmFtIHJlcHJlc2VudGF0aW9uIGlzIGFzDQo+ID4g
KyAgICAgICAgICBmb2xsb3dzOg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgVkREDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgfHwtLSsNCj4gPiArICAgICAgICAgICAgICAgKy0tLS0tb3x8ICAgICBQLU1PUy1GRVQNCj4g
PiArICAgICAgICAgICAgICAgfCAgICAgIHx8LS0rDQo+ID4gKyAgICAgICAgICBJTiAtLSsgICAg
ICAgICAgKy0tLS0tIG91dA0KPiA+ICsgICAgICAgICAgICAgICB8ICAgICAgfHwtLSsNCj4gPiAr
ICAgICAgICAgICAgICAgKy0tLS0tLXx8ICAgICBOLU1PUy1GRVQNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgIHx8LS0rDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgR05EDQo+IA0KPiBOaWNlIHBpY3R1cmUhDQo+IA0KPiA+
ICsgICAgICAgICAgVGhlIGRyaXZpbmcgc3RyZW5ndGggb2YgdGhlIFAtTU9TL04tTU9TIHRyYW5z
aXN0b3JzIGltcGFjdHMNCj4gdGhlDQo+ID4gKyAgICAgICAgICB3YXZlZm9ybSdzIHJpc2UvZmFs
bCB0aW1lcy4gR3JlYXRlciBkcml2aW5nIHN0cmVuZ3RoIHJlc3VsdHMgaW4NCj4gPiArICAgICAg
ICAgIHNob3J0ZXIgcmlzZS9mYWxsIHRpbWVzLiBFYWNoIFAtTU9TIGFuZCBOLU1PUyB0cmFuc2lz
dG9yDQo+IG9mZmVycw0KPiA+ICsgICAgICAgICAgOCBjb25maWd1cmFibGUgbGV2ZWxzICgwIHRv
IDcpLCB3aXRoIGhpZ2hlciB2YWx1ZXMgaW5kaWNhdGluZw0KPiA+ICsgICAgICAgICAgZ3JlYXRl
ciBkcml2aW5nIHN0cmVuZ3RoLCBjb250cmlidXRpbmcgdG8gYWNoaWV2aW5nIHRoZSBkZXNpcmVk
DQo+ID4gKyAgICAgICAgICBzcGVlZC4NCj4gPiArDQo+ID4gKyAgICAgICAgICBUaGUgcmVhbHRl
ayxkcml2ZS1zdHJlbmd0aC1wIGlzIHVzZWQgdG8gY29udHJvbCB0aGUgZHJpdmluZw0KPiBzdHJl
bmd0aA0KPiA+ICsgICAgICAgICAgb2YgdGhlIFAtTU9TIG91dHB1dC4NCj4gPiArICAgICAgICAk
cmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gPiArICAgICAg
ICBtaW5pbXVtOiAwDQo+ID4gKyAgICAgICAgbWF4aW11bTogNw0KPiA+ICsNCj4gPiArICAgICAg
cmVhbHRlayxkcml2ZS1zdHJlbmd0aC1uOg0KPiA+ICsgICAgICAgIGRlc2NyaXB0aW9uOiB8DQo+
ID4gKyAgICAgICAgICBTaW1pbGFyIHRvIHRoZSByZWFsdGVrLGRyaXZlLXN0cmVuZ3RoLXAsIHRo
ZQ0KPiByZWFsdGVrLGRyaXZlLXN0cmVuZ3RoLW4NCj4gPiArICAgICAgICAgIGlzIHVzZWQgdG8g
Y29udHJvbCB0aGUgZHJpdmluZyBzdHJlbmd0aCBvZiB0aGUgTi1NT1Mgb3V0cHV0Lg0KPiA+ICsg
ICAgICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+
ICsgICAgICAgIG1pbmltdW06IDANCj4gPiArICAgICAgICBtYXhpbXVtOiA3DQo+IA0KPiBUaGVz
ZSB0d28gYXJlIHJlYWxseSBpbnRlcmVzdGluZy4gQnV0IHdoYXQgZG8gdGhlc2Ugc2V0dGluZ3Mg
cmVwcmVzZW50Pw0KPiANCj4gSSB3b3VsZCAqZ3Vlc3MqIGl0IHJlcHJlc2VudHMgdGhlIG51bWJl
ciBvZiB0cmFuc2lzdG9ycyB1c2VkLCBzaW1wbHksIHNvIDANCj4gbWVhbnMganVzdCBvbmUgUC9O
IHRyYW5zaXN0b3IgaXMgZHJpdmluZyBhbmQgNyBtZWFucyA4IHRyYW5zaXN0b3JzIGFyZSBkcml2
aW5nLg0KPiANCj4gQ2FuIHlvdSBwcm92aWRlIGRldGFpbHMgaGVyZT8NCj4gDQo+IEluIHRoaXMg
Y2FzZSwgbWF5YmUgd2Ugd2FudCBhIGdlbmVyYWxpemVkIHByb3BlcnR5IHN1Y2ggYXMgZHJpdmUt
c3RhZ2VzLXAgPQ0KPiA8bj47IGRyaXZlLXN0YWdlcy1uID0gPG4+Ow0KPiANCj4gaW4gdGhlIGdl
bmVyaWMgYmluZGluZ3MsIGlmIHRoaXMgd2lsbCBhcHBlYXIgZnJvbSBtb3JlIHZlbmRvcnM/DQo+
IA0KDQpUaGVzZSB2YWx1ZXMgYXJlIG5vdCBhIHNpbXBsZSBjb3VudCBvZiB0cmFuc2lzdG9ycyAo
c28gMCBpcyBub3QgMSB0cmFuc2lzdG9yKS4NCg0KSW5zdGVhZCwgdGhlIDMtYml0IHZhbHVlIHJl
cHJlc2VudHMgbGlrZSBhIHdlaWdodGVkIGNvbmZpZ3VyYXRpb24uIFRoZXJlIGlzIGEgYmFzZQ0K
ZHJpdmluZyBjYXBhYmlsaXR5IChldmVuIGF0IHZhbHVlIDApLCBhbmQgZWFjaCBiaXQgYWRkcyBh
IGRpZmZlcmVudCB3ZWlnaHQgdG8gdGhlDQp0b3RhbCBzdHJlbmd0aCAoZS5nLiwgQml0IDAgYWRk
cyBhIHNtYWxsIHdlaWdodCwgQml0IDIgYWRkcyBhIGxhcmdlciB3ZWlnaHQpLg0KDQpUaGUgcmVz
dWx0aW5nIGN1cnJlbnQgaXMgbm9uLWxpbmVhciBhbmQgYWxzbyB2YXJpZXMgc2lnbmlmaWNhbnRs
eSBiYXNlZCBvbiB0aGUgSU8NCnZvbHRhZ2UgKDEuOFYgdnMgMy4zVikgYW5kIHRoZSBzcGVjaWZp
YyBwYWQgZ3JvdXAgKGUuZy4sIGVNTUMgdnMgU0RJTykuDQoNCkdpdmVuIHRoaXMgY29tcGxleGl0
eSwgSSBhbSBub3Qgc3VyZSBpZiB0aGlzIGltcGxlbWVudGF0aW9uIGlzIHN1aXRhYmxlIGZvciBh
DQpnZW5lcmljIGJpbmRpbmcgc2hhcmVkIHdpdGggb3RoZXIgdmVuZG9ycy4NCg0KPiA+ICsgICAg
ICByZWFsdGVrLGR1dHktY3ljbGU6DQo+ID4gKyAgICAgICAgZGVzY3JpcHRpb246IHwNCj4gPiAr
ICAgICAgICAgIEFuIGludGVnZXIgZGVzY3JpYmluZyB0aGUgbGV2ZWwgdG8gYWRqdXN0IG91dHB1
dCBkdXR5IGN5Y2xlLA0KPiA+ICsgICAgICAgICAgY29udHJvbGxpbmcgdGhlIHByb3BvcnRpb24g
b2YgcG9zaXRpdmUgYW5kIG5lZ2F0aXZlIHdhdmVmb3Jtcw0KPiBpbg0KPiA+ICsgICAgICAgICAg
bmFub3NlY29uZHMuDQo+ID4gKyAgICAgICAgICBWYWxpZCBhcmd1bWVudHMgYXJlIGRlc2NyaWJl
ZCBhcyBiZWxvdzoNCj4gPiArICAgICAgICAgIDA6IDBucw0KPiA+ICsgICAgICAgICAgMjogKyAw
LjI1bnMNCj4gPiArICAgICAgICAgIDM6ICsgMC41bnMNCj4gPiArICAgICAgICAgIDQ6IC0wLjI1
bnMNCj4gPiArICAgICAgICAgIDU6IC0wLjVucw0KPiA+ICsgICAgICAgICRyZWY6IC9zY2hlbWFz
L3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ICsgICAgICAgIGVudW06IFswLCAy
LCAzLCA0LCA1XQ0KPiANCj4gVGhpcyBpcyBhIGJpdCBkdWJpb3VzLg0KPiANCj4gSXNuJ3QgdGhp
cyBvbmUgb2YgdGhvc2UgY2FzZXMgd2hlcmUgeW91IHNob3VsZCBiZSB1c2luZyB0aGUgUFdNIGJp
bmRpbmdzLA0KPiBkaXJlY3RseSBpbiB0aGlzIG5vZGU/IEp1c3Qgc2xhbSBpbiAjcHdtLWNlbGxz
ID0gPC4uLj4gZXRjLCBJIHRoaW5rIHRoaXMgaXMgd2hhdCB5b3UNCj4gcmVhbGx5IHdhbnQuDQo+
IA0KPiBQbGVhc2UgY29uc3VsdC9yZWZlcmVuY2U6DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9wd20vcHdtLnlhbWwNCj4gY29uc3VtZXJzIHdvdWxkIG5vdCB1c2UgcGluY3Ry
bCBwaGFuZGxlcyBidXQgc29tZXRoaW5nIGxpa2UgcHdtcyA9DQo+IDwmcHdtIC4uLi4+Ow0KPiAN
Cj4gSXQncyBtYXliZSBhIGJpdCB0cml4eSB0byB1c2UgdHdvIGdlbmVyaWMgYmluZGluZ3MgaW4g
dGhlIG5vZGUgYnV0IGl0IHNob3VsZCBiZQ0KPiBqdXN0IGZpbmUuDQo+IA0KPiBJIGRvbid0IGZl
ZWwgY29uZmlkZW50IG1lcmdlaW5nIHRoaXMgd2l0aG91dCBVd2UgS2xlaW5lLUvDtm5pZydzIHJl
dmlldy4NCj4gDQoNClRoaXMgaGFyZHdhcmUgYmxvY2sgaXMgbm90IGEgUFdNIGdlbmVyYXRvci4g
SXQgZG9lcyBub3QgZ2VuZXJhdGUgYSBzaWduYWwgd2l0aCBhDQpzcGVjaWZpYyBmcmVxdWVuY3kg
YW5kIGR1dHkgcmF0aW8uDQoNCkluc3RlYWQsIGl0IHByb3ZpZGVzIGEgZml4ZWQgbmFub3NlY29u
ZC1sZXZlbCBhZGp1c3RtZW50IHRvIHRoZSByaXNpbmcvZmFsbGluZyBlZGdlcw0Kb2YgYW4gZXhp
c3Rpbmcgc2lnbmFsLiBJdCBpcyB1c2VkIGZvciBTaWduYWwgSW50ZWdyaXR5IHR1bmluZyAoYWRk
aW5nL3N1YnRyYWN0aW5nDQpkZWxheSB0byBmaW5lLXR1bmUgdGhlIGhpZ2gvbG93IGR1cmF0aW9u
KS4NCg0KVG8gYXZvaWQgY29uZnVzaW9uIHdpdGggUFdNIGJpbmRpbmdzLCB3b3VsZCB5b3Ugc3Vn
Z2VzdCBhIG5hbWUgbGlrZQ0KcmVhbHRlayxwdWxzZS13aWR0aC1hZGp1c3Q/DQoNCj4gPiArICAg
ICAgcmVhbHRlayxpbnB1dC12b2x0YWdlOg0KPiA+ICsgICAgICAgIGRlc2NyaXB0aW9uOiB8DQo+
ID4gKyAgICAgICAgICBTZWxlY3QgdGhlIGlucHV0IHJlY2VpdmVyIHZvbHRhZ2UgZG9tYWluIGZv
ciB0aGUgcGluICgxLjhWIG9yDQo+IDMuM1YpLg0KPiA+ICsgICAgICAgICAgVGhpcyBkZWZpbmVz
IHRoZSByZWZlcmVuY2UgZm9yIFZJSC9WSUwgYW5kIG11c3QgbWF0Y2ggdGhlDQo+IGV4dGVybmFs
DQo+ID4gKyAgICAgICAgICBzaWduYWwgbGV2ZWwuDQo+ID4gKw0KPiA+ICsgICAgICAgICAgVGhp
cyBkb2VzIG5vdCBjb250cm9sIHRoZSBvdXRwdXQgZHJpdmUgdm9sdGFnZSwgd2hpY2ggaXMgaGFu
ZGxlZA0KPiBieQ0KPiA+ICsgICAgICAgICAgdGhlIHN0YW5kYXJkIGdlbmVyaWMgJ3Bvd2VyLXNv
dXJjZScgcHJvcGVydHkuDQo+ID4gKw0KPiA+ICsgICAgICAgICAgVmFsaWQgYXJndW1lbnRzIGFy
ZSBkZXNjcmliZWQgYXMgYmVsb3c6DQo+ID4gKyAgICAgICAgICAwOiAxLjhWIGlucHV0IGxvZ2lj
IGxldmVsDQo+ID4gKyAgICAgICAgICAxOiAzLjNWIGlucHV0IGxvZ2ljIGxldmVsDQo+ID4gKyAg
ICAgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4g
KyAgICAgICAgZW51bTogWzAsIDFdDQo+IA0KPiBUaGlzIGxvb2tzIHZlcnkgZ2VuZXJpYy4gQ2Fu
IHlvdSBwbGVhc2UganVzdCBhZGQgaW5wdXQtdm9sdGFnZSB0bw0KPiBwaW5jZmctbm9kZS55YW1s
IHdpdGggYSBjdXN0b20gZm9ybWF0IGFuZCByZWZlcmVuY2UgdGhhdD8NCj4gDQoNCkkgd2lsbCBk
byBpdCBpbiB2Mi4NCg0KPiA+ICsgICAgICByZWFsdGVrLGhpZ2gtdmlsOg0KPiA+ICsgICAgICAg
IHR5cGU6IGJvb2xlYW4NCj4gPiArICAgICAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsgICAgICAg
ICAgU2VsZWN0IHRoZSBpbnB1dCByZWNlaXZlciB3aXRoIGEgaGlnaGVyIExPVyByZWNvZ25pdGlv
bg0KPiB0aHJlc2hvbGQNCj4gPiArICAgICAgICAgIChWSUwpIHRvIGltcHJvdmUgZGV0ZWN0aW9u
IGZvciBzb3VyY2VzIHdpdGggd2VhayBwdWxsLWRvd24gb3INCj4gc2xvdw0KPiA+ICsgICAgICAg
ICAgZmFsbGluZyBlZGdlcy4NCj4gDQo+IElzbid0IHRoaXMgc3VwcG9zZWQgdG8gYmUgaW5wdXQt
c2NobWl0dC1taWNyb3ZvbHQ/DQo+IA0KPiBPciBpcyB0aGlzIHNvbWV0aGluZyBlbHNlIHRoYW4g
YSBzY2htaXR0IHRyaWdnZXI/DQo+IA0KPiBJbiBlaXRoZXIgY2FzZSwgdHJ5IHRvIGZpZ3VyZSBv
dXQgdGhlIHR5cGljYWwgcmVjb2duaXRpb24gdGhyZXNob2xkIGluIG1pY3Jvdm9sdA0KPiBhbmQg
dXNlIHRoYXQsIHBsZWFzZS4NCj4gDQoNClRoaXMgaXMgbm90IGEgY29uZmlndXJhdGlvbiBmb3Ig
dGhlIFNjaG1pdHQgdHJpZ2dlciBoeXN0ZXJlc2lzIHdpbmRvdywgYnV0IHJhdGhlcg0KYSBzZWxl
Y3Rpb24gb2YgdGhlIGlucHV0IGxvdyB2b2x0YWdlIGxldmVsIChWSUwpIHRvIGFkZHJlc3MgYSBz
cGVjaWZpYyBIRE1JIEkyQw0KY29tcGF0aWJpbGl0eSBpc3N1ZS4NCg0KV2UgaGF2ZSBlbmNvdW50
ZXJlZCBzb21lIEhETUkgc2lua3MgKFRWcykgd2l0aCB3ZWFrIHB1bGwtZG93biBjYXBhYmlsaXRp
ZXMuDQpUaGVzZSBkZXZpY2VzIGZhaWwgdG8gcHVsbCB0aGUgSTJDIGJ1cyB2b2x0YWdlIGJlbG93
IHRoZSBzdGFuZGFyZCBWSUwgdGhyZXNob2xkDQoofjAuN1YpLCBjYXVzaW5nIHRoZSBTb0MgdG8g
ZmFpbCB0byByZWNvZ25pemUgdGhlIExPVyBzdGF0ZS4NCg0KVGhpcyBwcm9wZXJ0eSBlbmFibGVz
IGEgc3BlY2lhbGl6ZWQgaW5wdXQgcmVjZWl2ZXIgbW9kZSB0aGF0IHJhaXNlcyB0aGUgZWZmZWN0
aXZlDQpWSUwgdGhyZXNob2xkIHRvIGFwcHJveGltYXRlbHkgMS4xVi4NCg0KVGhlIGhhcmR3YXJl
IGRlc2lnbiBvbmx5IHN1cHBvcnRzIHRoZXNlIHR3byBkaXNjcmV0ZSBsZXZlbHMgKFN0YW5kYXJk
IH4wLjdWIGFuZA0KSGlnaC1WSUwgfjEuMVYpLg0KDQpTaW5jZSB0aGUgaGFyZHdhcmUgYWN0cyBh
cyBhIGRpc2NyZXRlIHN3aXRjaCBiZXR3ZWVuIHRoZXNlIHR3byBsZXZlbHMsIGRvIHlvdSBwcmVm
ZXINCndlIHJlcGxhY2UgdGhpcyBib29sZWFuIHdpdGggYSB2YWx1ZS1iYXNlZCBwcm9wZXJ0eSwN
CnN1Y2ggYXMgcmVhbHRlayxoaWdoLXZpbC1taWNyb3ZvbHQgPSA8MTEwMDAwMD4/DQoNCkJlc3Qg
UmVnYXJkcywNCll1LUNodW4NCg0KPiBZb3VycywNCj4gTGludXMgV2FsbGVpag0K

