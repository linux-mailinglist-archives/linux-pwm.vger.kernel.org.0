Return-Path: <linux-pwm+bounces-7071-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3B1B28286
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Aug 2025 17:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05FD05E5A45
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Aug 2025 15:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BC61EBA0D;
	Fri, 15 Aug 2025 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="HumWy2W5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B92218A6AD;
	Fri, 15 Aug 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755270033; cv=none; b=aPEExRM6VXzKpDriNPSqm/pdlxTebL/d9avWXWRWUaHXzNUj4mvTgMqrAHpES/gmNoC2bNKyH7Ku4Tny7OZISv7f6nwFIYZWo3FFgicJRkJbNHAmYl/O5edST4Se+N4dstO7JvSlOwUJHTNcVTS3aLLMrAE9gVTmiVNS3B02xCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755270033; c=relaxed/simple;
	bh=QJ+GefEzyFcEwAS+70vDAuvMPZmfhf58cwap67z0FT8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=enZKrn3zYdxSFoB90oZuSK2WyPjo0vt+/N0RW8luf/TKBC8GyTeGsLDdQezv0Cm+9dq67aVt82dzPs74+gNzc6ySmlza1IdrqcaItPXLGNfu+uDDgFaieUnw5ignbPQ6ZwCUoMAGoyeQy/R8GqgNxwd/sKcBc813+oJhLnRqBIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=HumWy2W5; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7hYqEYSofQc4Pj12ju3DeTtrqcNDIsRYqOnPsCVaJuE=; b=HumWy2W5Pvqz6AOjgYftSFfXVz
	UWNwt12IsOQBLoxoSTy4YfFHO6pLItA/LIDGAAcIi2EA3wqJvV/UzhRWfGxpo+7FLHMyx3KRj85bC
	Xhupv9tiTGrpYFDv7eOCEO9AP7HIef2MILjsAYQVq5eKTJSvIHgMB01QxKjupyBDTMz/ifdrdVxKE
	Jzz7PC7ntAG/29qqgG+w7vV0S25B4P9zhOQu27peU1HcRTC3lQ5h1uWKFQxrACIqJpwLn67yEuaEf
	g0CQbAYY6kR/AWjMl56V1tG9e2D5Tepoy+AG0OmCCVaHX91oLucXB2uKmZPPQBk02PQh0c+VpecIb
	Hp/uJSxw==;
Date: Fri, 15 Aug 2025 17:00:13 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, peter.ujfalusi@gmail.com,
 dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 lgirdwood@gmail.com, tiwai@suse.com, conor+dt@kernel.org, lee@kernel.org,
 ukleinek@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-usb@vger.kernel.org, shuah@kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 0/9] dt-bindings: Convert TWL4030/6040 family binding
 to DT schema
Message-ID: <20250815170013.6ffdac69@akair>
In-Reply-To: <20250814132129.138943-1-jihed.chaibi.dev@gmail.com>
References: <20250814132129.138943-1-jihed.chaibi.dev@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

Am Thu, 14 Aug 2025 15:21:20 +0200
schrieb Jihed Chaibi <jihed.chaibi.dev@gmail.com>:

> Hi,
> 
> This series modernizes the Device Tree bindings for the Texas
> Instruments TWL4030/TWL6040 family by converting all remaining
> legacy TXT bindings to the structured YAML DT schema format.
> 
> This improves the bindings by adding formal type checking, clear property
> definitions, and machine-readable examples, which allows for automated
> validation and better documentation for developers.
> 
> This v2 series addresses feedback from the initial submission, adds a new
> patch to fix validation errors that were uncovered by the stricter schemas,
> and includes several other minor improvements.
> 
for further submissions:
+CC: linux-omap@vger.kernel.org

That will help bringing the related people together. Apparently
MAINTAINERS needs to be updated, too. The drivers .c-files are listed
but not the bindings.

Regards,
Andreas

