Return-Path: <linux-pwm+bounces-8732-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMQJCb5+8GlSUAEAu9opvQ
	(envelope-from <linux-pwm+bounces-8732-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 11:32:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D27E74817A6
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 11:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0551A302395D
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 09:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B2239E19C;
	Tue, 28 Apr 2026 09:30:57 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D2139D6D6;
	Tue, 28 Apr 2026 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368657; cv=none; b=SUvDPHyzML22fYdABUGmGZwtWHo/62M7vrCMxmi/lvTZ8hVoNwZeMiuKobujEMIFIHo9DPTLTX4tofAAQbLKTCt2yNEjTavIgN4ikzNdOuh1bmo967huC7asM0frTL9SS2G1e1lecWQgnYS0oFNU9k4IHePRCmdCOl52Fq2Cdeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368657; c=relaxed/simple;
	bh=c0tk5d51VYQt3g3MNVbd50/HazxNiXCYqTNEMdUzAuQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=n/W4qjJHu6bUziG/Vi9c18S7lFwDI6WLVety3Gg6JGuojyrE/yN5aKNTfxyA5i/jevG01cRjAfe1jc05iZWJhiKYurvNvdWiEcVwl21IUyqFFLyvyjCiGAFIL1d+vjzXno/6+Jw8cBAgzfI/u3cuwY8oWzHnLvMHGqY5iekAbJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from dongxuyang$eswincomputing.com ( [10.12.96.41] ) by
 ajax-webmail-app2 (Coremail) ; Tue, 28 Apr 2026 17:30:32 +0800 (GMT+08:00)
Date: Tue, 28 Apr 2026 17:30:32 +0800 (GMT+08:00)
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
In-Reply-To: <ee58a5d6-9268-445c-a270-1f4a49b49c6e@kernel.org>
References: <20260424094529.1691-1-dongxuyang@eswincomputing.com>
 <20260424095435.1721-1-dongxuyang@eswincomputing.com>
 <ee58a5d6-9268-445c-a270-1f4a49b49c6e@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <622e18f1.5bb3.19dd36d0c40.Coremail.dongxuyang@eswincomputing.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:TQJkCgDH3aA4fvBpfFYVAA--.4903W
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/1tbiAQELAmnvj5oiO
	gABsD
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=
X-Rspamd-Queue-Id: D27E74817A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_NA(0.00)[eswincomputing.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8732-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongxuyang@eswincomputing.com,linux-pwm@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.932];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,eswincomputing.com:mid]

PiA+ICAKPiA+ICthbGxPZjoKPiA+ICsgIC0gJHJlZjogcHdtLnlhbWwjCj4gPiArCj4gPiArICAt
IGlmOgo+ID4gKyAgICAgIHByb3BlcnRpZXM6Cj4gPiArICAgICAgICBjb21wYXRpYmxlOgo+ID4g
KyAgICAgICAgICBjb250YWluczoKPiA+ICsgICAgICAgICAgICBjb25zdDogZXN3aW4sZWljNzcw
MC1wd20KPiAKPiBTYW1lIHByb2JsZW0gYXMgdjMgd2hpY2ggSSBjb21tZW50ZWQuIEkgZG8gbm90
IHVuZGVyc3RhbmQgd2h5IHlvdXIgbmV3Cj4gZGV2aWNlIGhhcyBhbHNvIDEgcmVzZXQuCj4gCj4g
WW91ciBjb21taXQgbXNnIE1VU1QgZXhwbGFpbiB3aHkgMSByZXNldCBpcyB2YWxpZC4KPiAKCkhp
IEtyenlzenRvZiwKCkFsdGhvdWdoIHRoZSBQV00gSVAgc3VwcG9ydHMgdHdvIGNsb2NrIGRvbWFp
bnMsIGVhY2ggcmVxdWlyaW5nIGEgcmVzZXQswqAKdGhlIEVJQzc3MDAgaW1wbGVtZW50YXRpb24g
dXNlcyB0aGUgc2FtZSBjbG9jayBkb21haW4gZm9yIGJvdGggY2xvY2vCoApzaWduYWxzLiBUaGVy
ZWZvcmUsIHRoZSBlaWM3NzAwLXB3bSBvbmx5IHN1cHBvcnRzIG9uZSByZXNldC4KVGhpcyBkZXNj
cmlwdGlvbiB3aWxsIGJlIHVwZGF0ZWQgaW4gdGhlIGJpbmRpbmcgY29tbWl0IGluIHRoZSBuZXh0
IHZlcnNpb24uCgpCZXN0IHJlZ2FyZHMsClh1eWFuZyBEb25nCg==

