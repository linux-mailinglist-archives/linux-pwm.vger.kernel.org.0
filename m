Return-Path: <linux-pwm+bounces-8290-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAovKjNcuWnYAgIAu9opvQ
	(envelope-from <linux-pwm+bounces-8290-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2026 14:50:43 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0942AB3CB
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2026 14:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BDAC30101F2
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2026 13:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488FA3A1E80;
	Tue, 17 Mar 2026 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="g4/Jflfm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D017308F32;
	Tue, 17 Mar 2026 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773755441; cv=none; b=QQUl8X2DWTmQ4owp1AVnp0HS2NhkKK5ScYTQ+sgHeIoy9wog+Ws/WpqLaD9zrzPEZtNt6T7G94QfeddGGQDogrQvBGqwW6F/Ns/AAv+Vc5jqQoCKB+Ba29WJOjXJH3a/yH4jN7ksHq7A7c35fKvh9hx56btForZd7nFmiO9RQO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773755441; c=relaxed/simple;
	bh=60m+sC8xedkAw0wCIxpY+XhBnIK+bJdRbfyBuWEq4UE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRu6Z1iTfWHgbbM/EDGo6c1RHKuE9jzPi4pXxXXReLcdXGtW9U24IYtM0XAWMPxi7o/xBclZ0oxauFe0XGhTe76ThyK3jMUJpzbEOHg/3tyoU/7lu8RDEn1kuvmOXSq2JjhWjyeniolQUL6GgtdrOvD5V0ITcw7yR7s7tCk/tEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=g4/Jflfm; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To; bh=sYFkhEmVfpmSdpk9zru8LsQsRcm++lmR5W2LLFKdA9g=; b=g4/Jflfmw3EwqKVV
	lRjwVeodNp64CSoP4uQY+9+Cez+2JadXM+l0vbErEW7AqD3YqvC/GC2b8Q7DN46jEUc4d7fEKxvdp
	AOO6Gh/pdMnhMg1UfO2p2K16tyQAwcpC3X47xU66qon4gdw9U2WCNnIRK28WHUV/XM+iYDSTIB/2K
	ZywYhIkS0XhR/2UeSKve62UWq0fkL4KfPoe97W2W+LAUs3enWdCh5ZTklrvGFSouUIZ6reQBuPm3S
	JYOwoeZraKdX9F/ndQFC1B8Uo9HBa7C/kUkhh5S9etoiXXqbj9OJSTOKZE9TE659F6QDxHGdGN2jG
	xqKo2NpJaOkJL4CH5w==;
Received: from [63.135.74.212] (helo=[192.168.1.241])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1w2UoM-009nfE-J8; Tue, 17 Mar 2026 13:50:18 +0000
Message-ID: <182d2cd5-82f6-41c0-b47a-7626de899f3d@codethink.co.uk>
Date: Tue, 17 Mar 2026 13:50:16 +0000
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Update designware pwm driver
To: Krzysztof Kozlowski <krzk@kernel.org>, dongxuyang@eswincomputing.com
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ben-linux@fluff.org, p.zabel@pengutronix.de,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ningyu@eswincomputing.com,
 linmin@eswincomputing.com, xuxiang@eswincomputing.com,
 wangguosheng@eswincomputing.com, pinkesh.vaghela@einfochips.com
References: <20260306093000.2065-1-dongxuyang@eswincomputing.com>
 <20260307-intrepid-curly-seagull-e036c4@quoll>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20260307-intrepid-curly-seagull-e036c4@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: ben.dooks@codethink.co.uk
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codethink.co.uk,reject];
	R_DKIM_ALLOW(-0.20)[codethink.co.uk:s=imap5-20230908];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8290-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[codethink.co.uk:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.dooks@codethink.co.uk,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,codethink.co.uk:dkim,codethink.co.uk:mid,codethink.co.uk:url]
X-Rspamd-Queue-Id: 1C0942AB3CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 07/03/2026 13:24, Krzysztof Kozlowski wrote:
> On Fri, Mar 06, 2026 at 05:30:00PM +0800, dongxuyang@eswincomputing.com wrote:
>> From: Xuyang Dong <dongxuyang@eswincomputing.com>
>>
>> There is already a patch [1] for the DesignWare PWM driver,
> 
> So provide review there instead of allowing Ben to post incomplete
> hardware description which you want to correct here...
> 
> I don't understand why posting this change.

I think the binding got merged a while ago whilst we ended up never
getting the go-ahead to finish the driver changes. Unfortunately
all the client hardware was returned and we had to destroy all the
data from them.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

