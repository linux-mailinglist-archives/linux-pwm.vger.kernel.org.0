Return-Path: <linux-pwm+bounces-9273-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8LJ3Gb/fJ2oj3wIAu9opvQ
	(envelope-from <linux-pwm+bounces-9273-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 09 Jun 2026 11:41:19 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 943CA65E6EB
	for <lists+linux-pwm@lfdr.de>; Tue, 09 Jun 2026 11:41:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9273-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9273-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED9B931798E6
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jun 2026 09:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4AD39EF30;
	Tue,  9 Jun 2026 09:31:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0534E2EA48F;
	Tue,  9 Jun 2026 09:31:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997518; cv=none; b=ZZQHajDf4JaJFGm4dl7KMnFcihB/B6jNAhIfYVmqiiIVsLI0Xq7t8gS57S9SDn6CuES8LhAvzSKlJf/yixpXWqQVcrWsfMxqU04qb1JTmZevRUEQMBAb3TZj/meiNAg9JK1TpCmtdc/hjgTc38Aec3KuB2yX0td70IGbYi2n7II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997518; c=relaxed/simple;
	bh=mTv1FIbYgG6vlkv8D3t7CfREq47u9+v5RbbqmW627C4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=QLuANaiyM6YRRHzJCNN4/HrBSD/MWlTqC4wT6AZGonQvzS2iHiQGT4eBpI+23dGKW1fnQa5Dhy5bqXrJ9X63hhXuEYJRe5+SUXOEZV1O2oNka98m46bH9CT80TMYphO45HWCY4qrinefi/g9IV4zLMs20MZAIwTnmdgz3tQwyPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.175.55.52
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Tue, 9 Jun 2026 17:31:28 +0800 (GMT+08:00)
Date: Tue, 9 Jun 2026 17:31:28 +0800 (GMT+08:00)
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
Subject: Re: Re: [PATCH v7 1/2] dt-bindings: pwm: dwc: Add eswin compatible
 and resets property
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.2-cmXT6 build
 20241203(6b039d88) Copyright (c) 2002-2026 www.mailtech.cn
 mispb-72143050-eaf5-4703-89e0-86624513b4ce-eswincomputing.com
In-Reply-To: <20260605-scrupulous-tasteful-nuthatch-5d8ce3@quoll>
References: <20260605082242.1541-1-dongxuyang@eswincomputing.com>
 <20260605082318.1599-1-dongxuyang@eswincomputing.com>
 <20260605-scrupulous-tasteful-nuthatch-5d8ce3@quoll>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <643f9b98.722f.19eabb8fe3e.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgAHHaBw3SdqhhclAA--.6758W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAQENAmom7qEx9
	gACsJ
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ben-linux@fluff.org,m:ben.dooks@codethink.co.uk,m:p.zabel@pengutronix.de,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ningyu@eswincomputing.com,m:linmin@eswincomputing.com,m:xuxiang@eswincomputing.com,m:wangguosheng@eswincomputing.com,m:pinkesh.vaghela@einfochips.com,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[eswincomputing.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[dongxuyang@eswincomputing.com,linux-pwm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9273-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongxuyang@eswincomputing.com,linux-pwm@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,eswincomputing.com:email,eswincomputing.com:mid,eswincomputing.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 943CA65E6EB

PiA+IAo+ID4gRUlDNzcwMCB1c2UgRGVzaWduV2FyZSBJUCBmb3IgUFdNIGNvbnRyb2xsZXJzLiBB
ZGQgRVNXSU4gRUlDNzcwMCBzdXBwb3J0Cj4gPiBpbiBzbnBzLGR3LWFwYi10aW1lcnMtcHdtMi55
YW1sLgo+ID4gCj4gPiBUaGUgRGVzaWduV2FyZSBQV00gaW5jbHVkZXMgc2VwYXJhdGUgcmVzZXQg
c2lnbmFscyBkZWRpY2F0ZWQgdG8gZWFjaCBjbG9jawo+ID4gZG9tYWluOgo+ID4gVGhlIHByZXNl
dG4gc2lnbmFsIHJlc2V0cyBsb2dpYyBpbiBwY2xrIGRvbWFpbi4KPiA+IFRoZSB0aW1lcl9OX3Jl
c2V0biBzaWduYWwgcmVzZXRzIGxvZ2ljIGluIHRoZSB0aW1lcl9OX2NsayBkb21haW4uCj4gPiBU
aGUgcmVzZXRzIGFyZSBhY3RpdmUtbG93Lgo+ID4gCj4gPiBUaGUgZ2VuZXJpYyBzbnBzLGR3LWFw
Yi10aW1lcnMtcHdtMiBiaW5kaW5nIGFsbG93cyBvbmUgb3IgdHdvIG9wdGlvbmFsCj4gCj4gSSBk
b24ndCBrbm93IHdoYXQgaXMgdGhlIGdlbmVyaWMgYmluZGluZywgYnV0IGl0IGRvZXMgbm90IGFs
bG93LiBPcGVuCj4gdGhlIGZpbGU6IHRoZXJlIGFyZSBubyByZXNldHMgYXQgYWxsLCBzbyBpdCBk
b2VzIG5vdCBhbGxvdyB0aGVtLiBPciB5b3UKPiBtaXhlZCB0ZW5zZXMgaGVyZSBhbmQgeW91IHdh
bnRlZCB0byBkZXNjcmliZSB0aGUgY2hhbmdlPwo+IAoKSGkgS3J6eXN6dG9mLAoKVGhhbmtzIGZv
ciB5b3VyIGNvbW1lbnRzIGFuZCB0aW1lLgoKUmVnYXJkaW5nIHNucHMsZHctYXBiLXRpbWVycy1w
d20yLCB3ZSBwcmV2aW91c2x5IGludGVuZGVkIHRvIGFkZCB0aGXCoApyZXNldHMgcHJvcGVydHkg
aW4gdGhlIHNhbWUgcGF0Y2guwqAKSG93ZXZlciwgYXMgeW91IHN1Z2dlc3RlZCwgd2Ugd2lsbCBz
cGxpdCBpdCBpbnRvIGEgc2VwYXJhdGUgcGF0Y2guCgo+IFRoZSBwcmVzZW50IHRlbnNlIGRlc2Ny
aWJlcyBjdXJyZW50IHN0YXRlIG9mIHNvdXJjZSBjb2RlIGJlZm9yZSBhcHBseWluZwo+IHRoZSBw
YXRjaC4gVGhlIHBhdGNoIHRyYW5zZm9ybSB0aGF0IGN1cnJlbnQgc3RhdGUsIHNvIHlvdSBkb24n
dCB1c2UKPiBwcmVzZW50IHRlbnNlIHRvIHNob3cgd2hhdCB3aWxsIGJlIGZ1dHVyZS4KPiAKPiBV
bmxlc3MgeW91IG1lYW50IGhlcmUgYSBkZXZpY2UsIG5vdCBiaW5kaW5nLiBJIHdvdWxkIGJlIHBp
Y2t5IGhlcmUKPiBleGNlcHQgdGhhdCB5b3VyIGJpbmRpbmcgaXMgaW5jb3JyZWN0IHdoaWNoIG1h
ZGUgbWUgbG9va2luZyBmb3IgYW5zd2Vycy4KPiBJIGNhbm5vdCBmaW5kIHRoZXNlIGFuc3dlcnMu
Cj4gCj4gPiByZXNldCBsaW5lcyBkZXBlbmRpbmcgb24gU29DIGludGVncmF0aW9uLgo+ID4gCj4g
PiBPbiBFSUM3NzAwLCB0aGUgcHJlc2V0biBhbmQgdGltZXJfTl9yZXNldG4gaW5wdXRzIGFyZSBw
aHlzaWNhbGx5IHRpZWQKPiA+IHRvIGEgc2luZ2xlIHJlc2V0IGxpbmUsIHRoZXJlZm9yZSBleGFj
dGx5IG9uZSByZXNldCBpcyByZXF1aXJlZC4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogWHV5YW5n
IERvbmcgPGRvbmd4dXlhbmdAZXN3aW5jb21wdXRpbmcuY29tPgo+ID4gLS0tCj4gPiAgLi4uL2Jp
bmRpbmdzL3B3bS9zbnBzLGR3LWFwYi10aW1lcnMtcHdtMi55YW1sIHwgMzggKysrKysrKysrKysr
KysrKystLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3B3bS9zbnBzLGR3LWFwYi10aW1lcnMtcHdtMi55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3B3bS9zbnBzLGR3LWFwYi10aW1lcnMtcHdtMi55YW1sCj4gPiBpbmRl
eCA3NTIzYTg5YTE3NzMuLmE0Yjc5MjlmMmUwNSAxMDA2NDQKPiA+IC0tLSBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vc25wcyxkdy1hcGItdGltZXJzLXB3bTIueWFtbAo+
ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9zbnBzLGR3LWFw
Yi10aW1lcnMtcHdtMi55YW1sCj4gPiBAQCAtMjAsMTIgKzIwLDExIEBAIGRlc2NyaXB0aW9uOgo+
ID4gICAgaW5zdGVhZCBvZiBoYXZpbmcgdG8gZW5jb2RlIHRoZSBJUCB2ZXJzaW9uIG51bWJlciBp
biB0aGUgZGV2aWNlIHRyZWUKPiA+ICAgIGNvbXBhdGlibGUuCj4gPiAgCj4gPiAtYWxsT2Y6Cj4g
PiAtICAtICRyZWY6IHB3bS55YW1sIwo+ID4gLQo+ID4gIHByb3BlcnRpZXM6Cj4gPiAgICBjb21w
YXRpYmxlOgo+ID4gLSAgICBjb25zdDogc25wcyxkdy1hcGItdGltZXJzLXB3bTIKPiA+ICsgICAg
ZW51bToKPiA+ICsgICAgICAtIHNucHMsZHctYXBiLXRpbWVycy1wd20yCj4gPiArICAgICAgLSBl
c3dpbixlaWM3NzAwLXB3bQo+ID4gIAo+ID4gICAgcmVnOgo+ID4gICAgICBtYXhJdGVtczogMQo+
ID4gQEAgLTQzLDYgKzQyLDEyIEBAIHByb3BlcnRpZXM6Cj4gPiAgICAgICAgLSBjb25zdDogYnVz
Cj4gPiAgICAgICAgLSBjb25zdDogdGltZXIKPiA+ICAKPiA+ICsgIHJlc2V0czoKPiA+ICsgICAg
bWluSXRlbXM6IDEKPiA+ICsgICAgaXRlbXM6Cj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogSW50
ZXJmYWNlIGJ1cyByZXNldAo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IFBXTSB0aW1lciBsb2dp
YyByZXNldAo+ID4gKwo+ID4gICAgc25wcyxwd20tbnVtYmVyOgo+ID4gICAgICAkcmVmOiAvc2No
ZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzIKPiA+ICAgICAgZGVzY3JpcHRpb246
IFRoZSBudW1iZXIgb2YgUFdNIGNoYW5uZWxzIGNvbmZpZ3VyZWQgZm9yIHRoaXMgaW5zdGFuY2UK
PiA+IEBAIC01NCw2ICs1OSwyMiBAQCByZXF1aXJlZDoKPiA+ICAgIC0gY2xvY2tzCj4gPiAgICAt
IGNsb2NrLW5hbWVzCj4gPiAgCj4gPiArYWxsT2Y6Cj4gPiArICAtICRyZWY6IHB3bS55YW1sIwo+
ID4gKwo+ID4gKyAgLSBpZjoKPiA+ICsgICAgICBwcm9wZXJ0aWVzOgo+ID4gKyAgICAgICAgY29t
cGF0aWJsZToKPiA+ICsgICAgICAgICAgY29udGFpbnM6Cj4gPiArICAgICAgICAgICAgY29uc3Q6
IGVzd2luLGVpYzc3MDAtcHdtCj4gPiArICAgIHRoZW46Cj4gPiArICAgICAgcHJvcGVydGllczoK
PiA+ICsgICAgICAgIHJlc2V0czoKPiA+ICsgICAgICAgICAgbWluSXRlbXM6IDEKPiAKPiBEcm9w
Cj4gCgpXaWxsIGZpeCBpbiB0aGUgbmV4dCB2ZXJzaW9uLgoKPiA+ICsgICAgICAgICAgbWF4SXRl
bXM6IDEKPiAKPiBTbyB5b3Ugd2FudCB0byBhZGQgcmVzZXRzIGZvciB0aGUgZXhpc3RpbmcgdmFy
aWFudCBjbGFpbWluZyB0aGF0IHRoZXkKPiB3ZXJlIG1pc3Npbmc/IFByb2JhYmx5IHdlIHNob3Vs
ZCB0ZWxsIHlvdSB0aGF0IGVhcmxpZXIsIGFsdGhvdWdoIHRoZQo+IHBhdGNoIHdhcyBnb2luZyBv
ZGQgZGlyZWN0aW9ucywgYnV0IHlvdSBuZWVkIHRvIHNwbGl0IGl0LiBGaXJzdCB5b3UgZml4Cj4g
ZXhpc3RpbmcgZGV2aWNlcyB3aXRoIGV4cGxhbmF0aW9uIHdoeS4gVGhlbiB5b3UgYWRkIG5ldyBj
b21wYXRpYmxlIHdpdGgKPiBjb25zdHJhaW50IGZvciBvbmUgcmVzZXQuCj4gCgpCYXNlZCBvbiB5
b3VyIGNvbW1lbnRzLCB3ZSB3aWxsIHNwbGl0IHRoaXMgcGF0Y2ggaW50byB0d28uIE9uZSBwYXRj
aMKgCmV4cGxhaW5zIHdoeSB3ZSBhZGQgdGhlIHJlc2V0cyBwcm9wZXJ0eSwgYW5kIHRoZSBvdGhl
ciBhZGRzIHRoZSBlc3dpbsKgCmNvbXBhdGlibGUgc3RyaW5nIGFuZCB0aGUgbGltaXQgZm9yIHJl
c2V0cy4KCkJlc3QgcmVnYXJkcywKWHV5YW5nIERvbmcK

