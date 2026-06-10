Return-Path: <linux-pwm+bounces-9277-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YojYJoUwKWqaSAMAu9opvQ
	(envelope-from <linux-pwm+bounces-9277-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jun 2026 11:38:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B955F667E7F
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jun 2026 11:38:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9277-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9277-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4029332910A
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jun 2026 09:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180BB383992;
	Wed, 10 Jun 2026 09:25:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6843C109D;
	Wed, 10 Jun 2026 09:25:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781083549; cv=none; b=brQ3Wld6bBZx8H7jDVTu+fjnhgK1+DN6Rcu+8NVa4+pPst214RhbzwXiU4/O21wkSt9zzzoiYqYJzONDjqlmI8tks/tH8sLDbjDPBeh27HIzAcaG4mS8V+yYXylWaI5HVGYOVvdAOARR7uXwTiHtnpZDim1NSETiT8gtTGMM4vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781083549; c=relaxed/simple;
	bh=hTh8Z4WzJirzBjWW9JmGHvJTie+/I/fSkwcPwxv2iTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=D9Dc6khtWeNi6BgvhYFRB+S0EjC4biLQkEF6u/rHQzM00+dldg+rS8Em1HXzwq28HQVG0Uer7CAnnLxFSWONuo/SR29sYo9gTfCOG0Bj8X3aKW6chWhXGV9PlCmzdcZd1iIU651JsNzu10NHIvKp/9UnL5XsyGVSoY8YlhZCEQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=207.46.229.174
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Wed, 10 Jun 2026 17:25:20 +0800 (GMT+08:00)
Date: Wed, 10 Jun 2026 17:25:20 +0800 (GMT+08:00)
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
In-Reply-To: <c4fa85f1-365e-49ab-9549-d6d46529a68b@kernel.org>
References: <20260605082242.1541-1-dongxuyang@eswincomputing.com>
 <20260605082318.1599-1-dongxuyang@eswincomputing.com>
 <20260605-scrupulous-tasteful-nuthatch-5d8ce3@quoll>
 <643f9b98.722f.19eabb8fe3e.Coremail.dongxuyang@eswincomputing.com>
 <c4fa85f1-365e-49ab-9549-d6d46529a68b@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <25b0baf0.731a.19eb0d9bf07.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgA3TJ+ALSlqTM4lAA--.5583W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAgEOAmooQJYbE
	gAAsS
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-9277-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongxuyang@eswincomputing.com,linux-pwm@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B955F667E7F

PiAKPiBPbiAwOS8wNi8yMDI2IDExOjMxLCBYdXlhbmcgRG9uZyB3cm90ZToKPiA+Pj4KPiA+Pj4g
RUlDNzcwMCB1c2UgRGVzaWduV2FyZSBJUCBmb3IgUFdNIGNvbnRyb2xsZXJzLiBBZGQgRVNXSU4g
RUlDNzcwMCBzdXBwb3J0Cj4gPj4+IGluIHNucHMsZHctYXBiLXRpbWVycy1wd20yLnlhbWwuCj4g
Pj4+Cj4gPj4+IFRoZSBEZXNpZ25XYXJlIFBXTSBpbmNsdWRlcyBzZXBhcmF0ZSByZXNldCBzaWdu
YWxzIGRlZGljYXRlZCB0byBlYWNoIGNsb2NrCj4gPj4+IGRvbWFpbjoKPiA+Pj4gVGhlIHByZXNl
dG4gc2lnbmFsIHJlc2V0cyBsb2dpYyBpbiBwY2xrIGRvbWFpbi4KPiA+Pj4gVGhlIHRpbWVyX05f
cmVzZXRuIHNpZ25hbCByZXNldHMgbG9naWMgaW4gdGhlIHRpbWVyX05fY2xrIGRvbWFpbi4KPiA+
Pj4gVGhlIHJlc2V0cyBhcmUgYWN0aXZlLWxvdy4KPiA+Pj4KPiA+Pj4gVGhlIGdlbmVyaWMgc25w
cyxkdy1hcGItdGltZXJzLXB3bTIgYmluZGluZyBhbGxvd3Mgb25lIG9yIHR3byBvcHRpb25hbAo+
ID4+Cj4gPj4gSSBkb24ndCBrbm93IHdoYXQgaXMgdGhlIGdlbmVyaWMgYmluZGluZywgYnV0IGl0
IGRvZXMgbm90IGFsbG93LiBPcGVuCj4gPj4gdGhlIGZpbGU6IHRoZXJlIGFyZSBubyByZXNldHMg
YXQgYWxsLCBzbyBpdCBkb2VzIG5vdCBhbGxvdyB0aGVtLiBPciB5b3UKPiA+PiBtaXhlZCB0ZW5z
ZXMgaGVyZSBhbmQgeW91IHdhbnRlZCB0byBkZXNjcmliZSB0aGUgY2hhbmdlPwo+ID4+Cj4gPiAK
PiA+IEhpIEtyenlzenRvZiwKPiA+IAo+ID4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIGFuZCB0
aW1lLgo+ID4gCj4gPiBSZWdhcmRpbmcgc25wcyxkdy1hcGItdGltZXJzLXB3bTIsIHdlIHByZXZp
b3VzbHkgaW50ZW5kZWQgdG8gYWRkIHRoZcKgCj4gPiByZXNldHMgcHJvcGVydHkgaW4gdGhlIHNh
bWUgcGF0Y2guwqAKPiA+IEhvd2V2ZXIsIGFzIHlvdSBzdWdnZXN0ZWQsIHdlIHdpbGwgc3BsaXQg
aXQgaW50byBhIHNlcGFyYXRlIHBhdGNoLgo+IAo+IEkgZmluZCBjb21taXQgbXNnIHN0aWxsIGNv
bmZ1c2luZy4gUGxlYXNlIGFsd2F5cyBjbGVhcmx5IGV4cGxhaW4gV0hZIHlvdQo+IGFyZSBkb2lu
ZyBjaGFuZ2VzLgo+IAoKSGkgS3J6eXN6dG9mLAoKVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLgoK
QWNjb3JkaW5nIHRvIHRoZSBEZXNpZ25XYXJlIElQIGZvciBQV00gY29udHJvbGxlcnMgbWFudWFs
LCBpdCBzZWVtcyB0byBtZcKgCnRoYXQgQmVuJ3MgcHJldmlvdXMgc3VibWlzc2lvbiBtYXkgaGF2
ZSBtaXNzZWQgdGhlIG9wdGlvbmFsIHJlc2V0cyBwcm9wZXJ0eS4KClRoZXJlZm9yZSwgSSB3b3Vs
ZCBsaWtlIHRvIGNvbmZpcm06IHNob3VsZCBJIHN1Ym1pdCBhIHNlcGFyYXRlIGZpeCBwYXRjaCBm
b3IKdGhlIHJlc2V0cyBwcm9wZXJ0eSwgb3IgaW5jbHVkZSBpdCBhcyBhIGZlYXR1cmUgcGF0Y2gg
aW4gdGhpcyBzZXJpZXM/CgpCZXN0IHJlZ2FyZHMsClh1eWFuZyBEb25nCg==

