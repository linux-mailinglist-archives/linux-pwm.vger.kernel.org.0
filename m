Return-Path: <linux-pwm+bounces-2459-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6459908AEC
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 13:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6578228A657
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jun 2024 11:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D69E195968;
	Fri, 14 Jun 2024 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lIakImVr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JIsqP68X"
X-Original-To: linux-pwm@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E888F195969;
	Fri, 14 Jun 2024 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718365110; cv=none; b=UBfmsj2mn9UbSE3wI16NXzk7zYV3R9W+0CfS4e8U/IAhVmbW3noczNKprzz8D/WzAlkuzSY0xooEcB8HCmfmxSxCkn9uM5uiRV223OqN2HAnoTlP4GdjEk21gP53E+Pe2B8+S0pZw6lGI+9Km9gsN4vYmDJB928lH2z/UdRNmE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718365110; c=relaxed/simple;
	bh=CZSgGkWoOuI7DARsF2UxT1J/Py8e0FgQB6J0c7F9d3M=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=X2Ll0fw4eba8Nj58QPUsoUbozD7v5jEWWK54fZ0bVSX4PfeT26teDb8ENRItptGrahuIB0UzcREo9p8kvPkzhY0cZsTtqJrGnZZZMzw7rH8JjAyR0HpIERxUfzXP4MqIdBcH7rvN5dk8NSUd1x3mQJ8jptMrIw/x6Ap9W+Nj70I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lIakImVr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JIsqP68X; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id D4B731380E21;
	Fri, 14 Jun 2024 07:38:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 14 Jun 2024 07:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1718365106;
	 x=1718451506; bh=3NfayYnmlRvX50JCu6Fxa2dE7HmSOX1tSGQYLGfPuE8=; b=
	lIakImVrYsbgeKXXAa+oLlm5jhZeVaisTL9Z2xBwLw7ECoRVsJB6okw67Te6ZpJW
	SFkF4nAL62pAS16KKEm9haW+o4bGOVaMx7gq6JQBkLaL9pUqsPqcbbXUIvFMwt98
	8s9xPddSAnjyUOALiTjzMuy/Iob8TCT53xIgmWlI7voqH8azS1TAbiS6u7Q5SbkY
	uyB2YJiQLn5XM2nLCAV3lOIFTmKcIrW3lyCcrdk4p3kj0zAUz/o+8lDmzHREjoxF
	+DBdCGCZHmN5fTzB/cGkH0XxIQX+qDu3QvyA4hMd9193ArBxwzhGoPXoA9Wrs0D0
	jQVPeSXOhQ1o6ch1Vveejw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718365106; x=
	1718451506; bh=3NfayYnmlRvX50JCu6Fxa2dE7HmSOX1tSGQYLGfPuE8=; b=J
	IsqP68XeQmNpekMXCQ+7ncl6eL1Hylf6u6bjVzLIiRqTFsyvmQFFrI3r5I1s+JdY
	IYTxTrgsHztTkT6hp/SpeCVL6iHb228GfQr8F/EoD4b9GOOMa7BpePhsqUIINngI
	aWTg42Y91sIALkepWKaqBXWC1Q6h03wTKO86DZK/pFaQcgFNT7mVGoGpW4a/hYbR
	32JtiVCbnXkmUCFVMHIvwVPcr9mQAD4X5Pbz+JR0LE/WCsG3L7aBmrZh/SWRlWVG
	7c8gdx3LxvqFO3eePLfLJyjtfWzNE2xDiVyAPvqHesz38ko5MTityRWbnI+SL3De
	+viiCZh7QAdSFhc4Yzb/A==
X-ME-Sender: <xms:sitsZm3Wm7o8EBsKfZCq7ZuxQRQ46bR5x-62MsH-O07SsBd2KEepOQ>
    <xme:sitsZpFWcvE0kpsR0gTPAqoYREw2JqwEBoi7LSWa77p9N178nlvjWC6io5S42wb6S
    OE_U_PyKKAj8PkyIqc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduledggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:sitsZu55gQpbRAMgoXlDJrfGk831dQZPyNYvDDOoU9UqA_IqK3c5wQ>
    <xmx:sitsZn0q-Ny-1CaSTHJjPzCt2arxwGyo_qbXvVwpj3gBmMJisQpFzg>
    <xmx:sitsZpEpVtkTjUjohpoIh7mUgoaLjhtAt4Zg2WLBQtn6F_tBNYt4Rw>
    <xmx:sitsZg-VmoMTlNqF7s6lF9WaWUDnzWmFK0NHNggYejYmnvTOEd65tw>
    <xmx:sitsZpDtVLur0NEYiBWXfrNnag3zyhQhinKZobyTkRtdU9GcWTy3goCq>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5C132B6008D; Fri, 14 Jun 2024 07:38:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1f13c705-dec7-48f6-a6d7-4a9000eedf7d@app.fastmail.com>
In-Reply-To: 
 <xj5mqnte5dgs4yzuku6g7gnprgm43tdbunxmo6o4thzreyraok@kttvkz5dhaei>
References: <20240614090829.560605-1-sean@mess.org>
 <xj5mqnte5dgs4yzuku6g7gnprgm43tdbunxmo6o4thzreyraok@kttvkz5dhaei>
Date: Fri, 14 Jun 2024 13:38:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 "Sean Young" <sean@mess.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] bus: ts-nbus: Use pwm_apply_might_sleep()
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024, at 12:06, Uwe Kleine-K=C3=B6nig wrote:
> On Fri, Jun 14, 2024 at 10:08:29AM +0100, Sean Young wrote:
>
> Thanks. I guess the patch becoming
> 8129d25e32b7fd0f77bc664252321f3a16bb26b8 was created a while before
> pwm_apply_might_sleep() was a thing.
>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
>
> Arnd, you merged the last changes to that driver. Do you want to care
> for that one, too? If not I can apply it via my pwm tree.

Whichever works best for you. I generally take drivers/bus
and drivers/soc fixes through the soc tree, but if this is
a PWM related change then having it in the pwm tree makes
sense as well.

If you like me to pick it up through the soc tree, please
forward the fix to soc@kernel.org.

      Arnd

