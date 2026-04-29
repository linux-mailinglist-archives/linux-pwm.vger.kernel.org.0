Return-Path: <linux-pwm+bounces-8744-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJuINJHQ8WlrkgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8744-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Apr 2026 11:34:09 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F39491F8D
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Apr 2026 11:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CED1030C7FED
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Apr 2026 09:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FA93C3C17;
	Wed, 29 Apr 2026 09:30:26 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661613BD25E;
	Wed, 29 Apr 2026 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455026; cv=none; b=Cy5ravnIxAMOvPE9TN1zmS7FuPHI8NBHV6B8FRtYKxmq3NtSynIlULHFdnsoyZLYMLWBOgZFFuse/vXjmH/aZYpgkXL4bW2FQ3TucQDMIWdsveIVLGhuw+GVLdGCYSfbrfaKXcVatilIiieOKVQ2qK50ktl0mSKAvldWEfpCMr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455026; c=relaxed/simple;
	bh=7kgD4cBDoa9BDLuThA7ZzUozXm/+LOVRP4yAm/zV6z8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=O6vgcBTT06Igxd+6Gq8vm+KO1KfTGTY1sNkU1/DgmHT0oaTNo2VsWUn1SohD+70T8GZgCo1KUGY8KpMkzquqG6fgQhm+mCp+GIfHMpnkxmYYlUkmIdYrwdINIIR1HE8lGDV0dZvSEQw96Yk7ta4xwGLQRUq9H75nnyfvhFw+U74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Wed, 29 Apr 2026 17:30:00 +0800 (GMT+08:00)
Date: Wed, 29 Apr 2026 17:30:00 +0800 (GMT+08:00)
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
In-Reply-To: <7bd6129a-dd37-48e8-a54c-cc149a2b84a2@kernel.org>
References: <20260424094529.1691-1-dongxuyang@eswincomputing.com>
 <20260424095435.1721-1-dongxuyang@eswincomputing.com>
 <ee58a5d6-9268-445c-a270-1f4a49b49c6e@kernel.org>
 <622e18f1.5bb3.19dd36d0c40.Coremail.dongxuyang@eswincomputing.com>
 <7bd6129a-dd37-48e8-a54c-cc149a2b84a2@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1ac7fae4.5c66.19dd892ec4d.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAnPqGYz_FpCq8VAA--.5067W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAQEMAmnw4RseG
	QAAsq
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Queue-Id: 32F39491F8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_NA(0.00)[eswincomputing.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8744-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongxuyang@eswincomputing.com,linux-pwm@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.861];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[eswincomputing.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

PiA+Pj4gIAo+ID4+PiArYWxsT2Y6Cj4gPj4+ICsgIC0gJHJlZjogcHdtLnlhbWwjCj4gPj4+ICsK
PiA+Pj4gKyAgLSBpZjoKPiA+Pj4gKyAgICAgIHByb3BlcnRpZXM6Cj4gPj4+ICsgICAgICAgIGNv
bXBhdGlibGU6Cj4gPj4+ICsgICAgICAgICAgY29udGFpbnM6Cj4gPj4+ICsgICAgICAgICAgICBj
b25zdDogZXN3aW4sZWljNzcwMC1wd20KPiA+Pgo+ID4+IFNhbWUgcHJvYmxlbSBhcyB2MyB3aGlj
aCBJIGNvbW1lbnRlZC4gSSBkbyBub3QgdW5kZXJzdGFuZCB3aHkgeW91ciBuZXcKPiA+PiBkZXZp
Y2UgaGFzIGFsc28gMSByZXNldC4KPiA+Pgo+ID4+IFlvdXIgY29tbWl0IG1zZyBNVVNUIGV4cGxh
aW4gd2h5IDEgcmVzZXQgaXMgdmFsaWQuCj4gPj4KPiA+IAo+ID4gSGkgS3J6eXN6dG9mLAo+ID4g
Cj4gPiBBbHRob3VnaCB0aGUgUFdNIElQIHN1cHBvcnRzIHR3byBjbG9jayBkb21haW5zLCBlYWNo
IHJlcXVpcmluZyBhIHJlc2V0LMKgCj4gPiB0aGUgRUlDNzcwMCBpbXBsZW1lbnRhdGlvbiB1c2Vz
IHRoZSBzYW1lIGNsb2NrIGRvbWFpbiBmb3IgYm90aCBjbG9ja8KgCj4gPiBzaWduYWxzLiBUaGVy
ZWZvcmUsIHRoZSBlaWM3NzAwLXB3bSBvbmx5IHN1cHBvcnRzIG9uZSByZXNldC4KPiA+Cj4gCj4g
SWYgd2Ugc3BlYWsgYWJvdXQgZWljNzcwMCwgZXhwbGFpbiB3aHkgaXQgaGFzIHR3byByZXNldHMg
bm93LCBhY2NvcmRpbmcKPiB0byBzY2hlbWEsIGV2ZW4gdGhvdWdoIHlvdSBzYXkgaXQgaGFzIG5v
dC4KPiAKPiBCdXQgSSB3YXMgc3BlYWtpbmcgYWJvdXQgZHctYXBiLXRpbWVycy1wd20sIHdoaWNo
IGhhcyBvbmUgcmVzZXQgYXMgd2VsbCEKPiBXaHkgeW91IGFyZSBub3QgaGF2aW5nIHByb3BlciBj
b25zdHJhaW50cz8gUGxlYXNlIHJlYWQgd3JpdGluZyBiaW5kaW5ncwo+IGRvY3VtZW50Lgo+IAoK
SGkgS3J6eXN6dG9mLAoKTGV0IG1lIGNsYXJpZnkgdGhlIHJlc2V0IHNpZ25hbHMuCsKgIC0gc25w
cyxkdy1hcGItdGltZXJzLXB3bTI6IElQIHNwZWMgaGFzIDIgb3B0aW9uYWwgcmVzZXQgc2lnbmFs
cyAob25lIHBlcgpjbG9jayBkb21haW4pLCBTb0MgdmVuZG9yIGRlY2lkZXMgd2hldGhlciB0byB3
aXJlIHRoZW0g4oCUIHNvIG1heEl0ZW1zOiAyLMKgCm9wdGlvbmFsIGluIHJlcXVpcmVkLgrCoCAt
IGVzd2luLGVpYzc3MDAtcHdtOiBTb0MgcGh5c2ljYWxseSB0aWVzIGJvdGggc2lnbmFscyB0byBv
bmUgcmVzZXQg4oCUIHNvCmV4YWN0bHkgMSwgcmVxdWlyZWQuCgpTbyBJIHRoaW5rIHRoZSBjb3Jy
ZWN0IHBhdGNoIHNob3VsZCBiZSBsaWtlIHRoaXM6Ck1vZGlmeSB0aGUgY29tbWl0IG1lc3NhZ2Ug
YXMgZm9sbG93czoKClRoZSBEZXNpZ25XYXJlIFBXTSBJUCBoYXMgdXAgdG8gdHdvIG9wdGlvbmFs
IHJlc2V0IHNpZ25hbHMsIG9uZSBwZXIgY2xvY2sKZG9tYWluIChwcmVzZXRuIGZvciBwY2xrLCB0
aW1lcl9OX3Jlc2V0biBmb3IgdGltZXJfTl9jbGspLgpTb0MgdmVuZG9ycyBkZWNpZGVzIHRvIHdp
cmUgdGhlbSwgc28gbWF4SXRlbXM6IDIgaXMgdGhlIHVwcGVyIGJvdW5kIGZvcsKgCnRoZSBnZW5l
cmljIHNucHMsZHctYXBiLXRpbWVycy1wd20yIGNvbXBhdGlibGUuCgpUaGUgRVNXSU4gRUlDNzcw
MCB0aWVzIGJvdGggcmVzZXQgZG9tYWlucyB0byBhIHNpbmdsZSBwaHlzaWNhbCByZXNldMKgCnNp
Z25hbCwgc28gZXhhY3RseSBvbmUgcmVzZXQgaXMgcmVxdWlyZWQuIEFkZCBtYXhJdGVtczogMSB0
byB0aGUgaWYtdGhlbsKgCmJsb2NrIGZvciBlc3dpbixlaWM3NzAwLXB3bSB0byBlbmZvcmNlIHRo
aXMuCgpNb2RpZnkgdGhlIFlBTUwgYXMgZm9sbG93czoKCi1hbGxPZjoKLcKgIC0gJHJlZjogcHdt
LnlhbWwjCi0KwqBwcm9wZXJ0aWVzOgrCoCDCoGNvbXBhdGlibGU6Ci3CoCDCoCBjb25zdDogc25w
cyxkdy1hcGItdGltZXJzLXB3bTIKK8KgIMKgIGVudW06CivCoCDCoCDCoCAtIHNucHMsZHctYXBi
LXRpbWVycy1wd20yCivCoCDCoCDCoCAtIGVzd2luLGVpYzc3MDAtcHdtCgrCoCDCoHJlZzoKwqAg
wqAgwqBtYXhJdGVtczogMQpAQCAtNDMsNiArNDIsMTMgQEAgcHJvcGVydGllczoKwqAgwqAgwqAg
wqAtIGNvbnN0OiBidXMKwqAgwqAgwqAgwqAtIGNvbnN0OiB0aW1lcgoKK8KgIHJlc2V0czoKK8Kg
IMKgIG1pbkl0ZW1zOiAxCivCoCDCoCBtYXhJdGVtczogMgorCsKgIMKgc25wcyxwd20tbnVtYmVy
OgrCoCDCoCDCoCRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMgrC
oCDCoCDCoGRlc2NyaXB0aW9uOiBUaGUgbnVtYmVyIG9mIFBXTSBjaGFubmVscyBjb25maWd1cmVk
IGZvciB0aGlzIGluc3RhbmNlCkBAIC01NCw2ICs2MCwyMSBAQCByZXF1aXJlZDoKwqAgwqAtIGNs
b2NrcwrCoCDCoC0gY2xvY2stbmFtZXMKCithbGxPZjoKK8KgIC0gJHJlZjogcHdtLnlhbWwjCisK
K8KgIC0gaWY6CivCoCDCoCDCoCBwcm9wZXJ0aWVzOgorwqAgwqAgwqAgwqAgY29tcGF0aWJsZToK
K8KgIMKgIMKgIMKgIMKgIGNvbnRhaW5zOgorwqAgwqAgwqAgwqAgwqAgwqAgY29uc3Q6IGVzd2lu
LGVpYzc3MDAtcHdtCivCoCDCoCB0aGVuOgorwqAgwqAgwqAgcHJvcGVydGllczoKK8KgIMKgIMKg
IMKgIHJlc2V0czoKK8KgIMKgIMKgIMKgIMKgIG1heEl0ZW1zOiAxCivCoCDCoCDCoCByZXF1aXJl
ZDoKK8KgIMKgIMKgIMKgIC0gcmVzZXRzCisKwqBhZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UK
CkRvIHlvdSB0aGluayB0aGlzIG1vZGlmaWNhdGlvbiBpcyBtb3JlIGFwcHJvcHJpYXRlPwoKQmVz
dCByZWdhcmRzLApYdXlhbmcgRG9uZwo=

