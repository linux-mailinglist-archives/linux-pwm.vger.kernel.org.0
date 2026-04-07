Return-Path: <linux-pwm+bounces-8507-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPl3FNK/1GmWwwcAu9opvQ
	(envelope-from <linux-pwm+bounces-8507-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Apr 2026 10:26:58 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE04E3AB4CE
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Apr 2026 10:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B86C302AF2E
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Apr 2026 08:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9902B3A545B;
	Tue,  7 Apr 2026 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CWG04K2G"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18113A3E7B
	for <linux-pwm@vger.kernel.org>; Tue,  7 Apr 2026 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550367; cv=none; b=YY8sneWq5JBKEjVZTSQUKU8warXlWtubs+/uq4o2NgJLbb+cqaYYIivIYU0d94YkWaTT8VjqeFLSGIzdDWovwyxfvPieojxgc0k23GmlaGTD2BmVoPiO9meTbKGinLQetzfFjgaD0AFrvRKuKZfrkWV4mOoR5VPM4E4Znul2rV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550367; c=relaxed/simple;
	bh=zqygcrO8Ojeqem5zuMJaEBnyLG60aJqsmeSRNn3NpUw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmsKQIy0KDjwnfoI7MyH6G7RR7WkJ8w2ILSar6pPGg4qzpxCY9yK5BsPqTgC9+6Y20cNQ/P8zLytnx4a68cMI54ZBQSfXamDmt/AnuKnq7qZpyCVx57Fhho6VDMbXdiQ40LSDKY1lNXk6O7/QLidlikQAVPpAfuXJkM7AfHuhZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CWG04K2G; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-482f454be5bso59757745e9.0
        for <linux-pwm@vger.kernel.org>; Tue, 07 Apr 2026 01:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775550364; x=1776155164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GAhnvdn7hKx6YnOufXJRDlAYALMzw6HqrxcTsLc/17U=;
        b=CWG04K2G8TgRZ+LclYnSa44LQoqFyCNQlgt1jfGxJMSw6BR4n2wUsg0AqKmEwYv3sq
         1ssmWtRC0WtWJ5X3rnsHJVRbd0vJsJ1TZ7nQCTMQr35yWMhl40rQL/Pcg/CnoPzKMpFy
         yrwoDEXIxOam/gC6ZuR5aoliDxJYBEU3wCKePmVgcyq4gT2rkG5BnAfDLFXFOOiKRrYn
         Oy2qbSWqsEQOApfkIOEjzAacZUS2ZV+1HZM6nMdjPReht4YApx90NBO+bXug8HS9+cUA
         vmaddclN9/kNxRXQxvpPDOmIIV1cLYfl7vxm3C6vZQee6SLxZthr4wp1tD8bGqmT6kgf
         2tHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775550364; x=1776155164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAhnvdn7hKx6YnOufXJRDlAYALMzw6HqrxcTsLc/17U=;
        b=DaS/+31qesQ8Mywb0ae4iKOl9nKsfzwZYeeUZiSMUyvo1KXf4J64wz66b3h9Qz/crz
         KAX1YL7C54qOTQbOkRmm7/1lxRM7Tohd0ZMG97HrGzQbPCy4oCsJX2jnKf5KEh3OzJ4H
         8kBtd7GLlgiTOaxgTurS4jCAgTkdw2ZLK42wsnl5VmkeWq4KglqN6l5ml9vEcd/iQIrg
         sAtgHPXy2fewh6DPrni5Igv47ThlC35rN/ZqLoYUpz5oyRDA+9r+a8OsF9cn22lc2DQ9
         FNKzNEMssLZVxm3gOBm3dEm7rBovOGqhZNhEumwvSPsksUdnStvMaFqyfC46cxYPedGV
         p38A==
X-Forwarded-Encrypted: i=1; AJvYcCUHvWIzhk/VL5I+N+rRQX575oZyHI+P6Dih/AAWSDw09Zj14TjSeiaosMgsNcdQ0MAIZwJRS9X30ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwABGe59bf+3fbqkZJ8ZOD+Vf2AFXZ/A1DNm/XtqAz79nTrXoaP
	2aOk+JwCKYgurJUVDp5mYBxTdwn+xoL9/pcV3JD+sgligiAfEoK5brfZwgnkMe9NTrg=
X-Gm-Gg: AeBDietaD/02EKPHimE+OJ3MgaRnJzMmTZHP4pxrR01NHi0iL7X1RthKfYu5eUYzrO+
	s2ZGea+cZhM5RwyevJ50OzJe+ZXUmYr8BQOhaaqEboiBO2owSmSmrd4DwhvwgA+QQIkZ/NHEQ+o
	es8Ydk1wljVsNNNqbOa6msXIbyWs31qS+ZLsgtV0PTgCYb/FA6sJx/aSeOm4BBi+9PP2Dt7DKNb
	2fCZk7iqfH8ftI3LPCVBVFfc2bcs//Yr7gBQ9DgLFlIUdpqCr1DtN/wkXFnsBDjC3VbDR6MXLzp
	yrwGk0TqKHHBXC/U0Og4qenZZpkHpV+wFZrjUPKZcPe4hLHwp9hVuufEhoZpxlYz0TnxgZAYDd1
	u6EgiaZ5wrK50AwXOXZx+8CyAxDOxnMv1TzKNZZUUe+WP2epvNwSzRZUHaocIsBavo93xZsnnWz
	EJ3AYjIse/C3/dBBTAQtHqZp7hVTX89BurXwneBQ0GySWXd4cgow==
X-Received: by 2002:a5d:5d0a:0:b0:43b:9b0a:7e80 with SMTP id ffacd0b85a97d-43d2115aed7mr29018679f8f.3.1775550363998;
        Tue, 07 Apr 2026 01:26:03 -0700 (PDT)
Received: from localhost (93-41-3-120.ip79.fastwebnet.it. [93.41.3.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c637asm46018051f8f.14.2026.04.07.01.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:26:03 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 7 Apr 2026 10:29:09 +0200
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Naushir Patuck <naush@raspberrypi.com>,
	Stanimir Varbanov <svarbanov@suse.de>
Subject: Re: [PATCH 1/3] dt-bindings: pwm: Add Raspberry Pi RP1 PWM controller
Message-ID: <adTAVQddjxHgoh9k@apocalypse>
References: <cover.1775223441.git.andrea.porta@suse.com>
 <11b5eee3c22cfd034bb4b425d28a5a3ff2a71828.1775223441.git.andrea.porta@suse.com>
 <20260405-enormous-glittering-avocet-285f82@quoll>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405-enormous-glittering-avocet-285f82@quoll>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8507-lists,linux-pwm=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.porta@suse.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE04E3AB4CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Krzysztof,

On 09:52 Sun 05 Apr     , Krzysztof Kozlowski wrote:
> On Fri, Apr 03, 2026 at 04:31:54PM +0200, Andrea della Porta wrote:
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +
> 
> Missing ref to pwm.yaml.

The reference to pwm.yaml is at line 13, as follows:

allOf:
  - $ref: pwm.yaml#

currently right after the maintainers: block. Are you
suggesting to move it after the required: block?

> 
> > +additionalProperties: false
> 
> and this should be unevaluatedProperties. See other files.

Ack.

Many thanks,
Andrea

> 
> Best regards,
> Krzysztof
> 

