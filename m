Return-Path: <linux-pwm+bounces-9038-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJbpKKGoDmr6AwYAu9opvQ
	(envelope-from <linux-pwm+bounces-9038-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 08:39:29 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C68B59F851
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 08:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5AA413010735
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 06:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3A3367299;
	Thu, 21 May 2026 06:36:11 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0691C3BFC;
	Thu, 21 May 2026 06:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345371; cv=none; b=aAW0yt36BQlXXZRP8KaSnJCfc2u4o3u+iZ1VkW2ncKzGQFWy/96vE6MynPn9TdccsiWfpIN7r5E0N/5MQXier6+vkAvS2+ZBkWeIcIiya0bADNbuTtXXkSV6CKTx2kZt+ZnecUsQK7aJI6HccfmyX/MZpykXStXFIj5l58S+S+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345371; c=relaxed/simple;
	bh=+0TkbJZfoYwBeGWH3VSlk4dWPNzrW1blyxABcP9lkf4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Mjry/VGzBvKawaYwAk5CXnsIUvC5KlUxOEC16J5K77O4A3zNWQc24mttFNNUIBnyC6NBjPPYvWS/IK+lZqK7B/6m4FXHyM4LzZHu+QEwtL3iPjfpIcUPeMIo73JOYOV+sj7+ZzXRxvPhww1B3trs8BGPKSn8d6kKfO7qa/Anzbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Thu, 21 May 2026 14:35:46 +0800 (GMT+08:00)
Date: Thu, 21 May 2026 14:35:46 +0800 (GMT+08:00)
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
In-Reply-To: <1d1a21a6-720d-4e8d-9798-27f8cc593403@kernel.org>
References: <20260424094529.1691-1-dongxuyang@eswincomputing.com>
 <20260424095435.1721-1-dongxuyang@eswincomputing.com>
 <ee58a5d6-9268-445c-a270-1f4a49b49c6e@kernel.org>
 <622e18f1.5bb3.19dd36d0c40.Coremail.dongxuyang@eswincomputing.com>
 <7bd6129a-dd37-48e8-a54c-cc149a2b84a2@kernel.org>
 <1ac7fae4.5c66.19dd892ec4d.Coremail.dongxuyang@eswincomputing.com>
 <b3a1b5ba-c381-407f-9118-aac7217138af@kernel.org>
 <f4f7edf.6067.19e15df803f.Coremail.dongxuyang@eswincomputing.com>
 <1d1a21a6-720d-4e8d-9798-27f8cc593403@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2e3c6632.66d0.19e493f4f19.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAnPJ_Cpw5qNSobAA--.4467W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgEOAmoN4pMRq
	QABsg
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_NA(0.00)[eswincomputing.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9038-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongxuyang@eswincomputing.com,linux-pwm@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,3.7.107.208:email,eswincomputing.com:mid]
X-Rspamd-Queue-Id: 9C68B59F851
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAKPiA+Pj4+Pj4+ICthbGxPZjoKPiA+Pj4+Pj4+ICsgIC0gJHJlZjogcHdtLnlhbWwjCj4gPj4+
Pj4+PiArCj4gPj4+Pj4+PiArICAtIGlmOgo+ID4+Pj4+Pj4gKyAgICAgIHByb3BlcnRpZXM6Cj4g
Pj4+Pj4+PiArICAgICAgICBjb21wYXRpYmxlOgo+ID4+Pj4+Pj4gKyAgICAgICAgICBjb250YWlu
czoKPiA+Pj4+Pj4+ICsgICAgICAgICAgICBjb25zdDogZXN3aW4sZWljNzcwMC1wd20KPiA+Pj4+
Pj4KPiA+Pj4+Pj4gU2FtZSBwcm9ibGVtIGFzIHYzIHdoaWNoIEkgY29tbWVudGVkLiBJIGRvIG5v
dCB1bmRlcnN0YW5kIHdoeSB5b3VyIG5ldwo+ID4+Pj4+PiBkZXZpY2UgaGFzIGFsc28gMSByZXNl
dC4KPiA+Pj4+Pj4KPiA+Pj4+Pj4gWW91ciBjb21taXQgbXNnIE1VU1QgZXhwbGFpbiB3aHkgMSBy
ZXNldCBpcyB2YWxpZC4KPiA+Pj4+Pj4KPiA+Pj4+Pgo+ID4+Pj4+IEhpIEtyenlzenRvZiwKPiA+
Pj4+Pgo+ID4+Pj4+IEFsdGhvdWdoIHRoZSBQV00gSVAgc3VwcG9ydHMgdHdvIGNsb2NrIGRvbWFp
bnMsIGVhY2ggcmVxdWlyaW5nIGEgcmVzZXQswqAKPiA+Pj4+PiB0aGUgRUlDNzcwMCBpbXBsZW1l
bnRhdGlvbiB1c2VzIHRoZSBzYW1lIGNsb2NrIGRvbWFpbiBmb3IgYm90aCBjbG9ja8KgCj4gPj4+
Pj4gc2lnbmFscy4gVGhlcmVmb3JlLCB0aGUgZWljNzcwMC1wd20gb25seSBzdXBwb3J0cyBvbmUg
cmVzZXQuCj4gPj4+Pj4KPiA+Pj4+Cj4gPj4+PiBJZiB3ZSBzcGVhayBhYm91dCBlaWM3NzAwLCBl
eHBsYWluIHdoeSBpdCBoYXMgdHdvIHJlc2V0cyBub3csIGFjY29yZGluZwo+ID4+Pj4gdG8gc2No
ZW1hLCBldmVuIHRob3VnaCB5b3Ugc2F5IGl0IGhhcyBub3QuCj4gPj4+Pgo+ID4+Pj4gQnV0IEkg
d2FzIHNwZWFraW5nIGFib3V0IGR3LWFwYi10aW1lcnMtcHdtLCB3aGljaCBoYXMgb25lIHJlc2V0
IGFzIHdlbGwhCj4gPj4+PiBXaHkgeW91IGFyZSBub3QgaGF2aW5nIHByb3BlciBjb25zdHJhaW50
cz8gUGxlYXNlIHJlYWQgd3JpdGluZyBiaW5kaW5ncwo+ID4+Pj4gZG9jdW1lbnQuCj4gPj4+Pgo+
ID4+Pgo+ID4+PiBIaSBLcnp5c3p0b2YsCj4gPj4+Cj4gPj4+IExldCBtZSBjbGFyaWZ5IHRoZSBy
ZXNldCBzaWduYWxzLgo+ID4+PiDCoCAtIHNucHMsZHctYXBiLXRpbWVycy1wd20yOiBJUCBzcGVj
IGhhcyAyIG9wdGlvbmFsIHJlc2V0IHNpZ25hbHMgKG9uZSBwZXIKPiA+Pj4gY2xvY2sgZG9tYWlu
KSwgU29DIHZlbmRvciBkZWNpZGVzIHdoZXRoZXIgdG8gd2lyZSB0aGVtIOKAlCBzbyBtYXhJdGVt
czogMizCoAo+ID4+PiBvcHRpb25hbCBpbiByZXF1aXJlZC4KPiA+Pgo+ID4+IFR3byByZXNldCBz
aWduYWxzIGJ1dCB3aGF0IGlzIGV4YWN0bHkgb3B0aW9uYWw/IEVhY2ggb2YgdGhlbT8gT25seSB0
aGUKPiA+PiBmaXJzdD8gQmluZGluZyBkb2VzIG5vdCBhbGxvdyB0aGUgZmlyc3QgdG8gYmUgb3B0
aW9uYWwuCj4gPj4KPiA+IAo+ID4gSGkgS3J6eXN6dG9mLAo+ID4gCj4gPiBUaGFuayB5b3UgZm9y
IHRoZSByZXZpZXcuIAo+ID4gCj4gPiBGb3IgdGhlIGdlbmVyaWMgc25wcyxkdy1hcGItdGltZXJz
LXB3bTIgYmluZGluZywgYm90aCByZXNldCBzaWduYWxzwqAKPiA+IGFyZSBub3cgZnVsbHkgb3B0
aW9uYWwgYnkgbm90IGluY2x1ZGluZyByZXNldHMgaW4gdGhlIHJlcXVpcmVkIGxpc3QuCj4gPiAK
PiA+IFdoZW4gYSBzaW5nbGUgb3B0aW9uYWwgcmVzZXQgc2lnbmFsIGlzIHVzZWQsIHRoZSBpbnRl
cmZhY2UgYnVzIHJlc2V0wqAKPiA+IChpbmRleCAwKSBpcyB1c2VkIGJ5IGRlZmF1bHQuCj4gPiAK
PiA+IEtlZXAgdGhlIFlBTUwgYXMgZm9sbG93czoKPiA+ICvCoCByZXNldHM6Cj4gPiArwqAgwqAg
bWluSXRlbXM6IDEKPiA+ICvCoCDCoCBpdGVtczoKPiA+ICvCoCDCoCDCoCAtIGRlc2NyaXB0aW9u
OiBJbnRlcmZhY2UgYnVzIHJlc2V0Cj4gPiArwqAgwqAgwqAgLSBkZXNjcmlwdGlvbjogUFdNIHRp
bWVyIGxvZ2ljIHJlc2V0Cj4gPiAKPiA+IEFkZCB0aGUgZm9sbG93aW5nIGRlc2NyaXB0aW9uIHRv
IHRoZSBjb21taXQgbWVzc2FnZToKPiAKPiBXZSBzcGVhayBhYm91dCBoYXJkd2FyZSwgbm90IGJp
bmRpbmcuIEkgYXNrZWQsIHdoeSB5b3VyIG5ldyBkZXZpY2UgaGFzCj4gb25seSBvbmUgcmVzZXQu
Cj4gCgpIaSBLcnp5c3p0b2YsCgpUaGFuayB5b3UgZm9yIHRoZSBkZXRhaWxlZCByZXZpZXcuCgpJ
IGRvbid0IHF1aXRlIHVuZGVyc3RhbmQgdGhlIG1lYW5pbmcgb2YgeW91ciBzZW50ZW5jZTogIldl
IHNwZWFrIGFib3V0wqAKaGFyZHdhcmUsIG5vdCBiaW5kaW5nLiBJIGFza2VkLCB3aHkgeW91ciBu
ZXcgZGV2aWNlIGhhcyBvbmx5IG9uZSByZXNldC4iCklmIHlvdSBtZWFuIHRoYXQgdGhlIGNvbW1p
dCBtZXNzYWdlIGluIGR0LWJpbmRpbmdzIGRvZXMgbm90IGFjY3VyYXRlbHnCoApkZXNjcmliZSB3
aHkgdGhlIEVJQzc3MDAgaGFzIG9ubHkgb25lIHJlc2V0LCBJIGhhdmUgcGFzdGVkIGJlbG93IHRo
ZcKgCmNvbXBsZXRlIGNvbW1pdCBtZXNzYWdlIHRoYXQgd2lsbCBiZSBpbmNsdWRlZCBpbiB0aGUg
bmV4dCB2NyB2ZXJzaW9uLgoKRG9lcyB0aGlzIGNvbW1pdCBtZXNzYWdlIGFkZHJlc3MgeW91ciBx
dWVzdGlvbj8KClRoZSBEZXNpZ25XYXJlIFBXTSBpbmNsdWRlcyBzZXBhcmF0ZSByZXNldCBzaWdu
YWxzIGRlZGljYXRlZCB0byBlYWNoIGNsb2NrCmRvbWFpbjoKVGhlIHByZXNldG4gc2lnbmFsIHJl
c2V0cyBsb2dpYyBpbiBwY2xrIGRvbWFpbi4KVGhlIHRpbWVyX05fcmVzZXRuIHNpZ25hbCByZXNl
dHMgbG9naWMgaW4gdGhlIHRpbWVyX05fY2xrIGRvbWFpbi4KVGhlIHJlc2V0cyBhcmUgYWN0aXZl
LWxvdy4KCkVJQzc3MDAgdXNlcyBEZXNpZ25XYXJlIElQIGZvciBQV00gY29udHJvbGxlcnMuIEFk
ZCBFU1dJTiBFSUM3NzAwIHN1cHBvcnQKaW4gc25wcyxkdy1hcGItdGltZXJzLXB3bTIueWFtbC4K
RUlDNzcwMCBwaHlzaWNhbGx5IHRpZXMgcHJlc2V0biBzaWduYWwgYW5kIHRpbWVyX05fcmVzZXRu
IHNpZ25hbCB0byBvbmUgcmVzZXTCoArigJQgc28gZXhhY3RseSAxLCByZXF1aXJlZC4KCj4gPiAK
PiA+IFdoZXRoZXIgZWFjaCBzaWduYWwgaXMgd2lyZWQgb24gYSBnaXZlbiBTb0MgaXMgYSBib2Fy
ZCBpbnRlZ3JhdGlvbsKgCj4gPiBkZWNpc2lvbiwgc28gdGhlIHJlc2V0cyBwcm9wZXJ0eSBpcyBv
cHRpb25hbCBmb3Igc25wcyxkdy1hcGItdGltZXJzLXB3bTIuwqAKPiA+IFdoZW4gcHJlc2VudCwg
dXAgdG8gdHdvIGhhbmRsZXMgbWF5IGJlIHN1cHBsaWVkOiB0aGUgYnVzIHJlc2V0IGlzIGFsd2F5
c8KgCj4gPiBhdCBpbmRleCAwIGFuZCB0aGUgdGltZXIgcmVzZXQgYXQgaW5kZXggMS4KPiA+IAo+
ID4+PiDCoCAtIGVzd2luLGVpYzc3MDAtcHdtOiBTb0MgcGh5c2ljYWxseSB0aWVzIGJvdGggc2ln
bmFscyB0byBvbmUgcmVzZXQg4oCUIHNvCj4gPj4+IGV4YWN0bHkgMSwgcmVxdWlyZWQuCj4gPj4K
PiA+PiBUaGVuIHR3byB3b3VsZCBub3QgYmUgcmlnaHQgYW5kIHlvdSBuZWVkIHRvIHJlc3RyaWN0
IHRoYXQuCj4gPj4KPiA+IAo+ID4gRm9yIHRoZSBzcGVjaWZpYyBlc3dpbixlaWM3NzAwLXB3bSBi
aW5kaW5nLCB0aGUgcmVzZXQgc2lnbmFsIGlzIHJlcXVpcmVkwqAKPiA+IGFuZCBmaXhlZCB0byBv
bmUgdmlhIGNvbmRpdGlvbmFsIHNjaGVtYSAoaWY6dGhlbjopLCB3aXRoIG1heEl0ZW1zOiAxwqAK
PiA+IGFuZCByZXNldHMgYWRkZWQgdG8gcmVxdWlyZWQuIEFuZCBhZGQgYW4gZXhhbXBsZSBmb3Ig
ZXN3aW4sZWljNzcwMC1wd20uCj4gPiBUaGUgY2hhbmdlcyBhcmUgYXMgZm9sbG93czoKPiA+IAo+
ID4gK2FsbE9mOgo+ID4gK8KgIC0gJHJlZjogcHdtLnlhbWwjCj4gPiArCj4gPiArwqAgLSBpZjoK
PiA+ICvCoCDCoCDCoCBwcm9wZXJ0aWVzOgo+ID4gK8KgIMKgIMKgIMKgIGNvbXBhdGlibGU6Cj4g
PiArwqAgwqAgwqAgwqAgwqAgY29udGFpbnM6Cj4gPiArwqAgwqAgwqAgwqAgwqAgwqAgY29uc3Q6
IGVzd2luLGVpYzc3MDAtcHdtCj4gPiArwqAgwqAgdGhlbjoKPiA+ICvCoCDCoCDCoCBwcm9wZXJ0
aWVzOgo+ID4gK8KgIMKgIMKgIMKgIHJlc2V0czoKPiA+ICvCoCDCoCDCoCDCoCDCoCBtYXhJdGVt
czogMQo+ID4gK8KgIMKgIMKgIHJlcXVpcmVkOgo+ID4gK8KgIMKgIMKgIMKgIC0gcmVzZXRzCj4g
PiArCj4gPiAKPiA+ICvCoCAtIHwKPiA+ICvCoCDCoCBwd21ANTA4MTgwMDAgewo+ID4gK8KgIMKg
IMKgIGNvbXBhdGlibGUgPSAiZXN3aW4sZWljNzcwMC1wd20iOwo+ID4gK8KgIMKgIMKgIHJlZyA9
IDwweDUwODE4MDAwIDB4NDAwMD47Cj4gPiArwqAgwqAgwqAgI3B3bS1jZWxscyA9IDwzPjsKPiA+
ICvCoCDCoCDCoCBjbG9ja3MgPSA8JmJ1cz4sIDwmdGltZXI+Owo+ID4gK8KgIMKgIMKgIGNsb2Nr
LW5hbWVzID0gImJ1cyIsICJ0aW1lciI7Cj4gPiArwqAgwqAgwqAgcmVzZXRzID0gPCZyZXNldD47
Cj4gPiArwqAgwqAgfTsKPiA+IAo+ID4gVGhlbiBjaGFuZ2UgdGhlIGJpbmRpbmcncyBzdWJqZWN0
IGZyb20gImR0LWJpbmRpbmdzOiBwd206IGR3YzogYWRkIG9wdGlvbmFswqAKPiA+IHJlc2V0IiB0
byAiZHQtYmluZGluZ3M6IHB3bTogZHdjOiBhZGQgZXN3aW4sZWljNzcwMC1wd20gY29tcGF0aWJs
ZSBhbmQgcmVzZXRzIi4KPiA+IAo+ID4gRG8gdGhlc2UgY2hhbmdlcyBsb29rIGFjY2VwdGFibGUg
dG8geW91Pwo+IAo+IFNvIHR3byByZXNldHMgb3Igb25lIHJlc2V0PyBJIGFtIGNvbXBsZXRlbHkg
Y29uZnVzZWQgd2hhdCB5b3UgYXJlCj4gcmVwbHlpbmcgdG8uCj4gCj4gUGxlYXNlIHJlYWQgd3Jp
dGluZyBiaW5kaW5ncyBkb2N1bWVudC4KPiAKCkkgdGhpbmsgdGhlICJyZXNldHMiIGluIHRoZSBz
dWJqZWN0IGlzIGFtYmlndW91cy4gSXQgY291bGQgbWlzbGVhZCBwZW9wbGUKaW50byB0aGlua2lu
ZyB0aGF0IHRoZSBFSUM3NzAwIGhhcyBtdWx0aXBsZSByZXNldCBzaWduYWxzLgpJIHRoaW5rIHRo
ZSBzdWJqZWN0IHNob3VsZCBiZSBjaGFuZ2VkIHRvwqAKImR0LWJpbmRpbmdzOiBwd206IGR3Yzog
QWRkIGVzd2luIGNvbXBhdGlibGUgYW5kIHJlc2V0cyBwcm9wZXJ0eSIuCgpCZXN0IHJlZ2FyZHMs
Clh1eWFuZyBEb25nCg==

