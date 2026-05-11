Return-Path: <linux-pwm+bounces-8854-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPplNgaBAWqebgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8854-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 09:11:02 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F6A508E6D
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 09:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFFB1300F7A6
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 07:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C84331218;
	Mon, 11 May 2026 07:10:55 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52F330C62E;
	Mon, 11 May 2026 07:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778483455; cv=none; b=b4qC/CCml6rgiCfqtufdyDA8JWZklmLlO0R8KwP5GE9QWVceqsgyrlsIZuyGaXbrWOvmGVurT/dT4lLBUAHX1w4RY7wG46REpLZXGVbNeFe0l0WYrVboKpAenOxf7hhHAuX0hyASd3J8cp5N7J8NKuFNZGo7JLKHzeImjr2ZnhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778483455; c=relaxed/simple;
	bh=tQxop21xxS9wiQS4QdTFhfxGSUkqI2+IyUF9gXD+W7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=o/Q1ato/4D69mFDc2JF5GhOP5JuUWnDW/X7rBX8feoLPHoSzIId/gJuXESw4G+K8HFp5hReBXsB8JJfZowK9AFlPwI5N/Fj7W0ed4bvC+MHDqpRxHkNN9Nl7K0FgMmvWF3BjROSm488fvjQeu3dydQ+aVaLuexwTb7Y8Tt9Y8vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Mon, 11 May 2026 15:10:29 +0800 (GMT+08:00)
Date: Mon, 11 May 2026 15:10:29 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Xuyang Dong" <dongxuyang@eswincomputing.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk,
	p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v6 1/2] dt-bindings: pwm: dwc: add optional reset
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <b3a1b5ba-c381-407f-9118-aac7217138af@kernel.org>
References: <20260424094529.1691-1-dongxuyang@eswincomputing.com>
 <20260424095435.1721-1-dongxuyang@eswincomputing.com>
 <ee58a5d6-9268-445c-a270-1f4a49b49c6e@kernel.org>
 <622e18f1.5bb3.19dd36d0c40.Coremail.dongxuyang@eswincomputing.com>
 <7bd6129a-dd37-48e8-a54c-cc149a2b84a2@kernel.org>
 <1ac7fae4.5c66.19dd892ec4d.Coremail.dongxuyang@eswincomputing.com>
 <b3a1b5ba-c381-407f-9118-aac7217138af@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <f4f7edf.6067.19e15df803f.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAHHaDlgAFqVH4YAA--.4958W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgEEAmoAs5Ea-
	gABso
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Queue-Id: 29F6A508E6D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8854-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_NA(0.00)[eswincomputing.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[3.7.107.208:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongxuyang@eswincomputing.com,linux-pwm@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

PiAKPiBPbiAyOS8wNC8yMDI2IDExOjMwLCBYdXlhbmcgRG9uZyB3cm90ZToKPiA+Pj4+PiAgCj4g
Pj4+Pj4gK2FsbE9mOgo+ID4+Pj4+ICsgIC0gJHJlZjogcHdtLnlhbWwjCj4gPj4+Pj4gKwo+ID4+
Pj4+ICsgIC0gaWY6Cj4gPj4+Pj4gKyAgICAgIHByb3BlcnRpZXM6Cj4gPj4+Pj4gKyAgICAgICAg
Y29tcGF0aWJsZToKPiA+Pj4+PiArICAgICAgICAgIGNvbnRhaW5zOgo+ID4+Pj4+ICsgICAgICAg
ICAgICBjb25zdDogZXN3aW4sZWljNzcwMC1wd20KPiA+Pj4+Cj4gPj4+PiBTYW1lIHByb2JsZW0g
YXMgdjMgd2hpY2ggSSBjb21tZW50ZWQuIEkgZG8gbm90IHVuZGVyc3RhbmQgd2h5IHlvdXIgbmV3
Cj4gPj4+PiBkZXZpY2UgaGFzIGFsc28gMSByZXNldC4KPiA+Pj4+Cj4gPj4+PiBZb3VyIGNvbW1p
dCBtc2cgTVVTVCBleHBsYWluIHdoeSAxIHJlc2V0IGlzIHZhbGlkLgo+ID4+Pj4KPiA+Pj4KPiA+
Pj4gSGkgS3J6eXN6dG9mLAo+ID4+Pgo+ID4+PiBBbHRob3VnaCB0aGUgUFdNIElQIHN1cHBvcnRz
IHR3byBjbG9jayBkb21haW5zLCBlYWNoIHJlcXVpcmluZyBhIHJlc2V0LMKgCj4gPj4+IHRoZSBF
SUM3NzAwIGltcGxlbWVudGF0aW9uIHVzZXMgdGhlIHNhbWUgY2xvY2sgZG9tYWluIGZvciBib3Ro
IGNsb2NrwqAKPiA+Pj4gc2lnbmFscy4gVGhlcmVmb3JlLCB0aGUgZWljNzcwMC1wd20gb25seSBz
dXBwb3J0cyBvbmUgcmVzZXQuCj4gPj4+Cj4gPj4KPiA+PiBJZiB3ZSBzcGVhayBhYm91dCBlaWM3
NzAwLCBleHBsYWluIHdoeSBpdCBoYXMgdHdvIHJlc2V0cyBub3csIGFjY29yZGluZwo+ID4+IHRv
IHNjaGVtYSwgZXZlbiB0aG91Z2ggeW91IHNheSBpdCBoYXMgbm90Lgo+ID4+Cj4gPj4gQnV0IEkg
d2FzIHNwZWFraW5nIGFib3V0IGR3LWFwYi10aW1lcnMtcHdtLCB3aGljaCBoYXMgb25lIHJlc2V0
IGFzIHdlbGwhCj4gPj4gV2h5IHlvdSBhcmUgbm90IGhhdmluZyBwcm9wZXIgY29uc3RyYWludHM/
IFBsZWFzZSByZWFkIHdyaXRpbmcgYmluZGluZ3MKPiA+PiBkb2N1bWVudC4KPiA+Pgo+ID4gCj4g
PiBIaSBLcnp5c3p0b2YsCj4gPiAKPiA+IExldCBtZSBjbGFyaWZ5IHRoZSByZXNldCBzaWduYWxz
Lgo+ID4gwqAgLSBzbnBzLGR3LWFwYi10aW1lcnMtcHdtMjogSVAgc3BlYyBoYXMgMiBvcHRpb25h
bCByZXNldCBzaWduYWxzIChvbmUgcGVyCj4gPiBjbG9jayBkb21haW4pLCBTb0MgdmVuZG9yIGRl
Y2lkZXMgd2hldGhlciB0byB3aXJlIHRoZW0g4oCUIHNvIG1heEl0ZW1zOiAyLMKgCj4gPiBvcHRp
b25hbCBpbiByZXF1aXJlZC4KPiAKPiBUd28gcmVzZXQgc2lnbmFscyBidXQgd2hhdCBpcyBleGFj
dGx5IG9wdGlvbmFsPyBFYWNoIG9mIHRoZW0/IE9ubHkgdGhlCj4gZmlyc3Q/IEJpbmRpbmcgZG9l
cyBub3QgYWxsb3cgdGhlIGZpcnN0IHRvIGJlIG9wdGlvbmFsLgo+IAoKSGkgS3J6eXN6dG9mLAoK
VGhhbmsgeW91IGZvciB0aGUgcmV2aWV3LiAKCkZvciB0aGUgZ2VuZXJpYyBzbnBzLGR3LWFwYi10
aW1lcnMtcHdtMiBiaW5kaW5nLCBib3RoIHJlc2V0IHNpZ25hbHPCoAphcmUgbm93IGZ1bGx5IG9w
dGlvbmFsIGJ5IG5vdCBpbmNsdWRpbmcgcmVzZXRzIGluIHRoZSByZXF1aXJlZCBsaXN0LgoKV2hl
biBhIHNpbmdsZSBvcHRpb25hbCByZXNldCBzaWduYWwgaXMgdXNlZCwgdGhlIGludGVyZmFjZSBi
dXMgcmVzZXTCoAooaW5kZXggMCkgaXMgdXNlZCBieSBkZWZhdWx0LgoKS2VlcCB0aGUgWUFNTCBh
cyBmb2xsb3dzOgorwqAgcmVzZXRzOgorwqAgwqAgbWluSXRlbXM6IDEKK8KgIMKgIGl0ZW1zOgor
wqAgwqAgwqAgLSBkZXNjcmlwdGlvbjogSW50ZXJmYWNlIGJ1cyByZXNldAorwqAgwqAgwqAgLSBk
ZXNjcmlwdGlvbjogUFdNIHRpbWVyIGxvZ2ljIHJlc2V0CgpBZGQgdGhlIGZvbGxvd2luZyBkZXNj
cmlwdGlvbiB0byB0aGUgY29tbWl0IG1lc3NhZ2U6CgpXaGV0aGVyIGVhY2ggc2lnbmFsIGlzIHdp
cmVkIG9uIGEgZ2l2ZW4gU29DIGlzIGEgYm9hcmQgaW50ZWdyYXRpb27CoApkZWNpc2lvbiwgc28g
dGhlIHJlc2V0cyBwcm9wZXJ0eSBpcyBvcHRpb25hbCBmb3Igc25wcyxkdy1hcGItdGltZXJzLXB3
bTIuwqAKV2hlbiBwcmVzZW50LCB1cCB0byB0d28gaGFuZGxlcyBtYXkgYmUgc3VwcGxpZWQ6IHRo
ZSBidXMgcmVzZXQgaXMgYWx3YXlzwqAKYXQgaW5kZXggMCBhbmQgdGhlIHRpbWVyIHJlc2V0IGF0
IGluZGV4IDEuCgo+ID4gwqAgLSBlc3dpbixlaWM3NzAwLXB3bTogU29DIHBoeXNpY2FsbHkgdGll
cyBib3RoIHNpZ25hbHMgdG8gb25lIHJlc2V0IOKAlCBzbwo+ID4gZXhhY3RseSAxLCByZXF1aXJl
ZC4KPiAKPiBUaGVuIHR3byB3b3VsZCBub3QgYmUgcmlnaHQgYW5kIHlvdSBuZWVkIHRvIHJlc3Ry
aWN0IHRoYXQuCj4gCgpGb3IgdGhlIHNwZWNpZmljIGVzd2luLGVpYzc3MDAtcHdtIGJpbmRpbmcs
IHRoZSByZXNldCBzaWduYWwgaXMgcmVxdWlyZWTCoAphbmQgZml4ZWQgdG8gb25lIHZpYSBjb25k
aXRpb25hbCBzY2hlbWEgKGlmOnRoZW46KSwgd2l0aCBtYXhJdGVtczogMcKgCmFuZCByZXNldHMg
YWRkZWQgdG8gcmVxdWlyZWQuIEFuZCBhZGQgYW4gZXhhbXBsZSBmb3IgZXN3aW4sZWljNzcwMC1w
d20uClRoZSBjaGFuZ2VzIGFyZSBhcyBmb2xsb3dzOgoKK2FsbE9mOgorwqAgLSAkcmVmOiBwd20u
eWFtbCMKKworwqAgLSBpZjoKK8KgIMKgIMKgIHByb3BlcnRpZXM6CivCoCDCoCDCoCDCoCBjb21w
YXRpYmxlOgorwqAgwqAgwqAgwqAgwqAgY29udGFpbnM6CivCoCDCoCDCoCDCoCDCoCDCoCBjb25z
dDogZXN3aW4sZWljNzcwMC1wd20KK8KgIMKgIHRoZW46CivCoCDCoCDCoCBwcm9wZXJ0aWVzOgor
wqAgwqAgwqAgwqAgcmVzZXRzOgorwqAgwqAgwqAgwqAgwqAgbWF4SXRlbXM6IDEKK8KgIMKgIMKg
IHJlcXVpcmVkOgorwqAgwqAgwqAgwqAgLSByZXNldHMKKwoKK8KgIC0gfAorwqAgwqAgcHdtQDUw
ODE4MDAwIHsKK8KgIMKgIMKgIGNvbXBhdGlibGUgPSAiZXN3aW4sZWljNzcwMC1wd20iOworwqAg
wqAgwqAgcmVnID0gPDB4NTA4MTgwMDAgMHg0MDAwPjsKK8KgIMKgIMKgICNwd20tY2VsbHMgPSA8
Mz47CivCoCDCoCDCoCBjbG9ja3MgPSA8JmJ1cz4sIDwmdGltZXI+OworwqAgwqAgwqAgY2xvY2st
bmFtZXMgPSAiYnVzIiwgInRpbWVyIjsKK8KgIMKgIMKgIHJlc2V0cyA9IDwmcmVzZXQ+OworwqAg
wqAgfTsKClRoZW4gY2hhbmdlIHRoZSBiaW5kaW5nJ3Mgc3ViamVjdCBmcm9tICJkdC1iaW5kaW5n
czogcHdtOiBkd2M6IGFkZCBvcHRpb25hbMKgCnJlc2V0IiB0byAiZHQtYmluZGluZ3M6IHB3bTog
ZHdjOiBhZGQgZXN3aW4sZWljNzcwMC1wd20gY29tcGF0aWJsZSBhbmQgcmVzZXRzIi4KCkRvIHRo
ZXNlIGNoYW5nZXMgbG9vayBhY2NlcHRhYmxlIHRvIHlvdT8KCkJlc3QgcmVnYXJkcywKWHV5YW5n
IERvbmcK

