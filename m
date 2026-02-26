Return-Path: <linux-pwm+bounces-8162-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iB3gCzgmoGk6fwQAu9opvQ
	(envelope-from <linux-pwm+bounces-8162-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Feb 2026 11:53:44 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0191A4A15
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Feb 2026 11:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6E62304C0B2
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Feb 2026 10:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7623C2820A0;
	Thu, 26 Feb 2026 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="qxBAwEAZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C6329B77C
	for <linux-pwm@vger.kernel.org>; Thu, 26 Feb 2026 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772102859; cv=none; b=p3l8xTfbxS9SmxGSov6W7UqS+cEEH7G0eTTl1XkuAmFmS681ICtvToDJIkNayvGfa5Z4kedNoALUk3TRqXgBklL/6Nd4MX/zpbO3o0mn4Uk5RsLpeovagFLGtZrc/opZjxm4zjhd1VBh2ylcoy5XMynvl8pYM4otqq2GiTH3bAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772102859; c=relaxed/simple;
	bh=oPFiUmRs6cNgeSFBo3/6oT3rABjczz6VVnJUaFgpFR4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mjug2F63NEfYbu0hosQTCwrMDreaUMARNI8zoiDmO6kiZpyJnIZlCGWkT5aSlutgueqkjNjrEVXQDefyDV8MgSbWdt8jauNfUeAWiDLToK6bLGcjCIeDpsfk3H4rJyU2vFil1Y9doLXeFXQZrCBtJlCmZjlcPnofsOiqe9gfizM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=qxBAwEAZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61QAlUiL53242878, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1772102851; bh=oPFiUmRs6cNgeSFBo3/6oT3rABjczz6VVnJUaFgpFR4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qxBAwEAZ/cJKqyycDtnIprhs32187JAoFzJ3ot2pRMU8EsA8vj5k/znaexdm05Q8r
	 gOuvpkF3uWHKMjXmZV4yDctBlVuaMWVVf3/HIwhEqcx2I+aE5ld6xCtX9FtAnNiTE4
	 2laVeo1ly9OEK9D5r8mpU+ZYHsqMRLCHQafL+ctcLJUWkzm1RvRRQ4ea3/tiw0YlI7
	 0GLS0C199aFMV3QMTT6u4Cz9CEqJ30b4XTL6D+Sj9TN8zRJYldQ0vK3NPllhaVv3sT
	 NwSIP0o1B58Kt6cz4klmwFZtpiV5WkvFwKuOTCaIIBns6Z8SKgPd4/JUdkX8cAWFfM
	 mTQq/SK3+Gssg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61QAlUiL53242878
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 18:47:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 26 Feb 2026 18:47:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Thu, 26 Feb 2026 18:47:30 +0800
From: =?utf-8?B?WXUtQ2h1biBMaW4gW+ael+elkOWQm10=?= <eleanor.lin@realtek.com>
To: Conor Dooley <conor@kernel.org>, Linus Walleij <linusw@kernel.org>
CC: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
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
Thread-Index: AQHckAe6vQgfzNK4QkiO7051ODDQUrVm/k4AgCxdpQCAAZ4ysA==
Date: Thu, 26 Feb 2026 10:47:30 +0000
Message-ID: <7450228dba6a4497b4cdf23747f5830b@realtek.com>
References: <20260128033936.27642-1-eleanor.lin@realtek.com>
 <20260128033936.27642-6-eleanor.lin@realtek.com>
 <CAD++jL=445wx467ZKE3-qm_BaVzKYXE-7zmReTFZA0KUAaSNyw@mail.gmail.com>
 <20260225-reconvene-troubling-947eb972cef8@spud>
In-Reply-To: <20260225-reconvene-troubling-947eb972cef8@spud>
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
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8162-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eleanor.lin@realtek.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E0191A4A15
X-Rspamd-Action: no action

PiBPbiBXZWQsIEphbiAyOCwgMjAyNiBhdCAwMTozMzowMFBNICswMTAwLCBMaW51cyBXYWxsZWlq
IHdyb3RlOg0KPiA+IEhpIFl1LUNodW4sDQo+ID4gDQo+ID4gdGhhbmtzIGZvciB5b3VyIHBhdGNo
IQ0KPiA+IA0KPiA+IFtVd2UsIGNhbiB5b3UgY2hlY2sgdGhpcyBhIGJpdCBkb3duIV0NCj4gPiAN
Cj4gPiBPbiBXZWQsIEphbiAyOCwgMjAyNiBhdCA0OjM54oCvQU0gWXUtQ2h1biBMaW4gPGVsZWFu
b3IubGluQHJlYWx0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IFR6dXlpIENoYW5nIDx0
eWNoYW5nQHJlYWx0ZWsuY29tPg0KPiA+DQo+ID4gQWRkIGRldmljZSB0cmVlIGJpbmRpbmdzIGZv
ciBSVEQxNjI1Lg0KPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBUenV5aSBDaGFuZyA8dHljaGFu
Z0ByZWFsdGVrLmNvbT4NCj4gPiA+IENvLWRldmVsb3BlZC1ieTogWXUtQ2h1biBMaW4gPGVsZWFu
b3IubGluQHJlYWx0ZWsuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogWXUtQ2h1biBMaW4gPGVs
ZWFub3IubGluQHJlYWx0ZWsuY29tPg0KPiA+IA0KPiA+IE92ZXJhbGwgdGhpcyBsb29rcyBnb29k
IQ0KPg0KPiBXaGVyZSBjYW4gSSBmaW5kIHRoZSBiaW5kaW5nIHBhdGNoPyBXaGF0IHRoaXMgaXMg
aW4tcmVwbHktdG8gZG9lcyBub3QNCj4gZXhpc3Q6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC9DQUQrK2pMPTQ0NXd4NDY3WktFMy1xbV9CYVZ6S1lYRS03em1SZVRGWkEwS1VBYVNOeXdA
bWFpbC5nbWFpbC5jb20vDQo+IE5vciBjYW4gSSBmaW5kIGFueXRoaW5nIGVsc2UgZnJvbSBFbGVh
bm9yIHRoYXQgd291bGQgYXBwZWFyIHRvIGJlIHdoYXQgdGhpcyBpczoNCj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLz9xPWYlM0FlbGVhbm9yLmxpbiU0MHJlYWx0ZWsuY29tDQo+DQoNCkhp
IENvbm9yLA0KDQpJIGFwb2xvZ2l6ZSBmb3IgdGhlIGNvbmZ1c2lvbi4gSSByZWFsaXplZCB0aGF0
IHdoZW4gSSBzZW50IG91dCB0aGUgdjEgcGF0Y2gsIEkNCm1pc3NlZCB0aGUgbWFpbGluZyBsaXN0
LCB3aGljaCBpcyB3aHkgaXQncyBub3Qgc2hvd2luZyB1cCBpbiB0aGUgYXJjaGl2ZXMuDQoNClNp
bmNlIEkgaGFkIGFscmVhZHkgcmVjZWl2ZWQgc29tZSBmZWVkYmFjayBvbiB2MSwgSSBtaXNzZWQg
dGhlIHRpbWluZyB0byByZXNlbmQgdGhlIHYxLg0KSG93ZXZlciwgeW91IHdlcmUgaW5jbHVkZWQg
aW4gdGhlIENDIGxpc3Qgb2YgdGhlIGluaXRpYWwgdjEgcGF0Y2ggZW1haWwuDQpZb3UgbWlnaHQg
YmUgYWJsZSB0byBmaW5kIHRoZSBmdWxsIHBhdGNoIGluIHlvdXIgaW5ib3guDQoNCj4gPg0KPiA+
ID4gKyAgICAgIHBvd2VyLXNvdXJjZToNCj4gPiA+ICsgICAgICAgIGRlc2NyaXB0aW9uOiB8DQo+
ID4gPiArICAgICAgICAgIFZhbGlkIGFyZ3VtZW50cyBhcmUgZGVzY3JpYmVkIGFzIGJlbG93Og0K
PiA+ID4gKyAgICAgICAgICAwOiBwb3dlciBzdXBwbHkgb2YgMS44Vg0KPiA+ID4gKyAgICAgICAg
ICAxOiBwb3dlciBzdXBwbHkgb2YgMy4zVg0KPiA+ID4gKyAgICAgICAgZW51bTogWzAsIDFdDQo+
ID4gDQo+ID4gT0suLi4NCj4gPiANCj4gPiA+ICsgICAgICBzbGV3LXJhdGU6DQo+ID4gPiArICAg
ICAgICBkZXNjcmlwdGlvbjogfA0KPiA+ID4gKyAgICAgICAgICBWYWxpZCBhcmd1bWVudHMgYXJl
IGRlc2NyaWJlZCBhcyBiZWxvdzoNCj4gPiA+ICsgICAgICAgICAgICAwOiB+MW5zIGZhbGxpbmcg
dGltZQ0KPiA+ID4gKyAgICAgICAgICAgIDE6IH4xMG5zIGZhbGxpbmcgdGltZQ0KPiA+ID4gKyAg
ICAgICAgICAgIDI6IH4yMG5zIGZhbGxpbmcgdGltZQ0KPiA+ID4gKyAgICAgICAgICAgIDM6IH4z
MG5zIGZhbGxpbmcgdGltZQ0KPiA+ID4gKyAgICAgICAgZW51bTogWzAsIDEsIDIsIDNdDQo+ID4g
DQo+ID4gU2xldyByYXRlIGlzIHVzdWFsbHkgc29tZXRoaW5nIGxpa2Ugdm9sdHMvc2Vjb25kIGlu
IFNJIHVuaXRzLCBJIHdvdWxkIA0KPiA+IGV4cGVjdCB0aGF0IHRoaXMgZGlmZmVycyBkZXBlbmRp
bmcgb24gd2hpY2ggcG93ZXItc291cmNlIGlzIHNlbGVjdGVkPw0KPiA+IEkuZS4gYXJlIHRoZXNl
IHZhbHVlcyBmb3IgMS44ViBvciAzLjNWPw0KPiA+IA0KPiA+ID4gKyAgICAgIHJlYWx0ZWssZHJp
dmUtc3RyZW5ndGgtcDoNCj4gPiA+ICsgICAgICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gPiArICAg
ICAgICAgIFNvbWUgb2YgcGlucyBjYW4gYmUgZHJpdmVuIHVzaW5nIHRoZSBQLU1PUyBhbmQgTi1N
T1MgdHJhbnNpc3RvciB0bw0KPiA+ID4gKyAgICAgICAgICBhY2hpZXZlIGZpbmVyIGFkanVzdG1l
bnRzLg0KPiA+IA0KPiA+IEZpbmVyIGNvbXBhcmVkIHRvIHdoYXQ/IENvbXBhcmVkIHRvIHRoZSBv
dmVyYWxsIHNldHRpbmcgZm9yIHNsZXctcmF0ZSANCj4gPiBvciBkcml2ZS1zdHJlbmd0aCwgb3Ig
Ym90aD8NCj4gPiANCj4gPiA+IFRoZSBibG9jay1kaWFncmFtIHJlcHJlc2VudGF0aW9uIGlzIGFz
DQo+ID4gPiArICAgICAgICAgIGZvbGxvd3M6DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgIFZERA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICB8fC0tKw0KPiA+ID4gKyAgICAgICAgICAgICAgICstLS0tLW98fCAg
ICAgUC1NT1MtRkVUDQo+ID4gPiArICAgICAgICAgICAgICAgfCAgICAgIHx8LS0rDQo+ID4gPiAr
ICAgICAgICAgIElOIC0tKyAgICAgICAgICArLS0tLS0gb3V0DQo+ID4gPiArICAgICAgICAgICAg
ICAgfCAgICAgIHx8LS0rDQo+ID4gPiArICAgICAgICAgICAgICAgKy0tLS0tLXx8ICAgICBOLU1P
Uy1GRVQNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgfHwtLSsNCj4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgR05E
DQo+ID4NCj4gPiBOaWNlIHBpY3R1cmUhDQo+ID4NCj4gPiA+ICsgICAgICAgICAgVGhlIGRyaXZp
bmcgc3RyZW5ndGggb2YgdGhlIFAtTU9TL04tTU9TIHRyYW5zaXN0b3JzIGltcGFjdHMgdGhlDQo+
ID4gPiArICAgICAgICAgIHdhdmVmb3JtJ3MgcmlzZS9mYWxsIHRpbWVzLiBHcmVhdGVyIGRyaXZp
bmcgc3RyZW5ndGggcmVzdWx0cyBpbg0KPiA+ID4gKyAgICAgICAgICBzaG9ydGVyIHJpc2UvZmFs
bCB0aW1lcy4gRWFjaCBQLU1PUyBhbmQgTi1NT1MgdHJhbnNpc3RvciBvZmZlcnMNCj4gPiA+ICsg
ICAgICAgICAgOCBjb25maWd1cmFibGUgbGV2ZWxzICgwIHRvIDcpLCB3aXRoIGhpZ2hlciB2YWx1
ZXMgaW5kaWNhdGluZw0KPiA+ID4gKyAgICAgICAgICBncmVhdGVyIGRyaXZpbmcgc3RyZW5ndGgs
IGNvbnRyaWJ1dGluZyB0byBhY2hpZXZpbmcgdGhlIGRlc2lyZWQNCj4gPiA+ICsgICAgICAgICAg
c3BlZWQuDQo+ID4gPiArDQo+ID4gPiArICAgICAgICAgIFRoZSByZWFsdGVrLGRyaXZlLXN0cmVu
Z3RoLXAgaXMgdXNlZCB0byBjb250cm9sIHRoZSBkcml2aW5nIHN0cmVuZ3RoDQo+ID4gPiArICAg
ICAgICAgIG9mIHRoZSBQLU1PUyBvdXRwdXQuDQo+ID4gPiArICAgICAgICAkcmVmOiAvc2NoZW1h
cy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gPiA+ICsgICAgICAgIG1pbmltdW06
IDANCj4gPiA+ICsgICAgICAgIG1heGltdW06IDcNCj4gPiA+ICsNCj4gPiA+ICsgICAgICByZWFs
dGVrLGRyaXZlLXN0cmVuZ3RoLW46DQo+ID4gPiArICAgICAgICBkZXNjcmlwdGlvbjogfA0KPiA+
ID4gKyAgICAgICAgICBTaW1pbGFyIHRvIHRoZSByZWFsdGVrLGRyaXZlLXN0cmVuZ3RoLXAsIHRo
ZSByZWFsdGVrLGRyaXZlLXN0cmVuZ3RoLW4NCj4gPiA+ICsgICAgICAgICAgaXMgdXNlZCB0byBj
b250cm9sIHRoZSBkcml2aW5nIHN0cmVuZ3RoIG9mIHRoZSBOLU1PUyBvdXRwdXQuDQo+ID4gPiAr
ICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4g
PiA+ICsgICAgICAgIG1pbmltdW06IDANCj4gPiA+ICsgICAgICAgIG1heGltdW06IDcNCj4gPg0K
PiA+IFRoZXNlIHR3byBhcmUgcmVhbGx5IGludGVyZXN0aW5nLiBCdXQgd2hhdCBkbyB0aGVzZSBz
ZXR0aW5ncyByZXByZXNlbnQ/DQo+ID4gDQo+ID4gSSB3b3VsZCAqZ3Vlc3MqIGl0IHJlcHJlc2Vu
dHMgdGhlIG51bWJlciBvZiB0cmFuc2lzdG9ycyB1c2VkLCBzaW1wbHksIA0KPiA+IHNvIDAgbWVh
bnMganVzdCBvbmUgUC9OIHRyYW5zaXN0b3IgaXMgZHJpdmluZyBhbmQgNyBtZWFucyA4IA0KPiA+
IHRyYW5zaXN0b3JzIGFyZSBkcml2aW5nLg0KPiA+IA0KPiA+IENhbiB5b3UgcHJvdmlkZSBkZXRh
aWxzIGhlcmU/DQo+ID4gDQo+ID4gSW4gdGhpcyBjYXNlLCBtYXliZSB3ZSB3YW50IGEgZ2VuZXJh
bGl6ZWQgcHJvcGVydHkgc3VjaCBhcyANCj4gPiBkcml2ZS1zdGFnZXMtcCA9IDxuPjsgZHJpdmUt
c3RhZ2VzLW4gPSA8bj47DQo+ID4gDQo+ID4gaW4gdGhlIGdlbmVyaWMgYmluZGluZ3MsIGlmIHRo
aXMgd2lsbCBhcHBlYXIgZnJvbSBtb3JlIHZlbmRvcnM/DQo+ID4gDQo+ID4gPiArICAgICAgcmVh
bHRlayxkdXR5LWN5Y2xlOg0KPiA+ID4gKyAgICAgICAgZGVzY3JpcHRpb246IHwNCj4gPiA+ICsg
ICAgICAgICAgQW4gaW50ZWdlciBkZXNjcmliaW5nIHRoZSBsZXZlbCB0byBhZGp1c3Qgb3V0cHV0
IGR1dHkgY3ljbGUsDQo+ID4gPiArICAgICAgICAgIGNvbnRyb2xsaW5nIHRoZSBwcm9wb3J0aW9u
IG9mIHBvc2l0aXZlIGFuZCBuZWdhdGl2ZSB3YXZlZm9ybXMgaW4NCj4gPiA+ICsgICAgICAgICAg
bmFub3NlY29uZHMuDQo+ID4gPiArICAgICAgICAgIFZhbGlkIGFyZ3VtZW50cyBhcmUgZGVzY3Jp
YmVkIGFzIGJlbG93Og0KPiA+ID4gKyAgICAgICAgICAwOiAwbnMNCj4gPiA+ICsgICAgICAgICAg
MjogKyAwLjI1bnMNCj4gPiA+ICsgICAgICAgICAgMzogKyAwLjVucw0KPiA+ID4gKyAgICAgICAg
ICA0OiAtMC4yNW5zDQo+ID4gPiArICAgICAgICAgIDU6IC0wLjVucw0KPiA+ID4gKyAgICAgICAg
JHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDMyDQo+ID4gPiArICAg
ICAgICBlbnVtOiBbMCwgMiwgMywgNCwgNV0NCj4gPg0KPiA+IFRoaXMgaXMgYSBiaXQgZHViaW91
cy4NCj4gPiANCj4gPiBJc24ndCB0aGlzIG9uZSBvZiB0aG9zZSBjYXNlcyB3aGVyZSB5b3Ugc2hv
dWxkIGJlIHVzaW5nIHRoZSBQV00gDQo+ID4gYmluZGluZ3MsIGRpcmVjdGx5IGluIHRoaXMgbm9k
ZT8gSnVzdCBzbGFtIGluICNwd20tY2VsbHMgPSA8Li4uPiBldGMsIA0KPiA+IEkgdGhpbmsgdGhp
cyBpcyB3aGF0IHlvdSByZWFsbHkgd2FudC4NCj4gPiANCj4gPiBQbGVhc2UgY29uc3VsdC9yZWZl
cmVuY2U6DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9wd20ueWFt
bA0KPiA+IGNvbnN1bWVycyB3b3VsZCBub3QgdXNlIHBpbmN0cmwgcGhhbmRsZXMgYnV0IHNvbWV0
aGluZyBsaWtlIHB3bXMgPSANCj4gPiA8JnB3bSAuLi4uPjsNCj4gPiANCj4gPiBJdCdzIG1heWJl
IGEgYml0IHRyaXh5IHRvIHVzZSB0d28gZ2VuZXJpYyBiaW5kaW5ncyBpbiB0aGUgbm9kZSBidXQg
aXQgDQo+ID4gc2hvdWxkIGJlIGp1c3QgZmluZS4NCj4gPiANCj4gPiBJIGRvbid0IGZlZWwgY29u
ZmlkZW50IG1lcmdlaW5nIHRoaXMgd2l0aG91dCBVd2UgS2xlaW5lLUvDtm5pZydzIHJldmlldy4N
Cj4NCj4gVGhpcyBkb2VzIHNvdW5kIGxpa2UgYSBwd20gdG8gbWUgdG9vLCBidXQgSSBjYW4ndCBz
ZWUgdGhlIHJlc3Qgb2YgdGhlIHNlcmllcyB0byBjb21tZW50Lg0KPg0KDQpQbGVhc2Uga2luZGx5
IHJlZmVyIHRvIG15IHJlc3BvbnNlIHRvIExpbnVzIFsxXS4NClsxXSBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvZDViZTM1N2MxNGI4NDE1NWFkZmE4YTlmMDBhNjRkODNAcmVhbHRlay5jb20v
DQoNCj4NCj4gPiA+ICsgICAgICByZWFsdGVrLGlucHV0LXZvbHRhZ2U6DQo+ID4gPiArICAgICAg
ICBkZXNjcmlwdGlvbjogfA0KPiA+ID4gKyAgICAgICAgICBTZWxlY3QgdGhlIGlucHV0IHJlY2Vp
dmVyIHZvbHRhZ2UgZG9tYWluIGZvciB0aGUgcGluICgxLjhWIG9yIDMuM1YpLg0KPiA+ID4gKyAg
ICAgICAgICBUaGlzIGRlZmluZXMgdGhlIHJlZmVyZW5jZSBmb3IgVklIL1ZJTCBhbmQgbXVzdCBt
YXRjaCB0aGUgZXh0ZXJuYWwNCj4gPiA+ICsgICAgICAgICAgc2lnbmFsIGxldmVsLg0KPiA+ID4g
Kw0KPiA+ID4gKyAgICAgICAgICBUaGlzIGRvZXMgbm90IGNvbnRyb2wgdGhlIG91dHB1dCBkcml2
ZSB2b2x0YWdlLCB3aGljaCBpcyBoYW5kbGVkIGJ5DQo+ID4gPiArICAgICAgICAgIHRoZSBzdGFu
ZGFyZCBnZW5lcmljICdwb3dlci1zb3VyY2UnIHByb3BlcnR5Lg0KPiA+ID4gKw0KPiA+ID4gKyAg
ICAgICAgICBWYWxpZCBhcmd1bWVudHMgYXJlIGRlc2NyaWJlZCBhcyBiZWxvdzoNCj4gPiA+ICsg
ICAgICAgICAgMDogMS44ViBpbnB1dCBsb2dpYyBsZXZlbA0KPiA+ID4gKyAgICAgICAgICAxOiAz
LjNWIGlucHV0IGxvZ2ljIGxldmVsDQo+ID4gPiArICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBl
cy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gPiA+ICsgICAgICAgIGVudW06IFswLCAxXQ0K
PiA+DQo+ID4gVGhpcyBsb29rcyB2ZXJ5IGdlbmVyaWMuIENhbiB5b3UgcGxlYXNlIGp1c3QgYWRk
IGlucHV0LXZvbHRhZ2UgdG8gDQo+ID4gcGluY2ZnLW5vZGUueWFtbCB3aXRoIGEgY3VzdG9tIGZv
cm1hdCBhbmQgcmVmZXJlbmNlIHRoYXQ/DQo+DQo+IFdoeSBhIGN1c3RvbSBmb3JtYXQsIHJhdGhl
ciB0aGFuIGlucHV0LXZvbHRhZ2UtbWljcm92b2x0IG9yIHcvZT8NCj4gDQoNCkkgd2lsbCBhZGQg
aW5wdXQtdm9sdGFnZS1taWNyb3ZvbHQgdG8gcGluY2ZnLW5vZGUueWFtbCBhbmQgdXNlIHRoZSBt
aWNyb3ZvbHQgZm9ybWF0DQphcyBzdWdnZXN0ZWQuIFRoYW5rcw0KDQpZdS1DaHVuDQoNCj4gQ2hl
ZXJzLA0KPiBDb25vci4NCj4NCj4gPg0KPiA+ID4gKyAgICAgIHJlYWx0ZWssaGlnaC12aWw6DQo+
ID4gPiArICAgICAgICB0eXBlOiBib29sZWFuDQo+ID4gPiArICAgICAgICBkZXNjcmlwdGlvbjog
fA0KPiA+ID4gKyAgICAgICAgICBTZWxlY3QgdGhlIGlucHV0IHJlY2VpdmVyIHdpdGggYSBoaWdo
ZXIgTE9XIHJlY29nbml0aW9uIHRocmVzaG9sZA0KPiA+ID4gKyAgICAgICAgICAoVklMKSB0byBp
bXByb3ZlIGRldGVjdGlvbiBmb3Igc291cmNlcyB3aXRoIHdlYWsgcHVsbC1kb3duIG9yIHNsb3cN
Cj4gPiA+ICsgICAgICAgICAgZmFsbGluZyBlZGdlcy4NCj4gPg0KPiA+IElzbid0IHRoaXMgc3Vw
cG9zZWQgdG8gYmUgaW5wdXQtc2NobWl0dC1taWNyb3ZvbHQ/DQo+ID4gDQo+ID4gT3IgaXMgdGhp
cyBzb21ldGhpbmcgZWxzZSB0aGFuIGEgc2NobWl0dCB0cmlnZ2VyPw0KPiA+IA0KPiA+IEluIGVp
dGhlciBjYXNlLCB0cnkgdG8gZmlndXJlIG91dCB0aGUgdHlwaWNhbCByZWNvZ25pdGlvbiB0aHJl
c2hvbGQgaW4gDQo+ID4gbWljcm92b2x0IGFuZCB1c2UgdGhhdCwgcGxlYXNlLg0KPiA+IA0KPiA+
IFlvdXJzLA0KPiA+IExpbnVzIFdhbGxlaWoNCg==

