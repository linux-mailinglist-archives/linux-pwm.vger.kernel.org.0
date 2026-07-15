Return-Path: <linux-pwm+bounces-9744-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1HiMMDt+V2rzSwAAu9opvQ
	(envelope-from <linux-pwm+bounces-9744-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 14:34:03 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2971175E2F4
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 14:34:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="i/6T1AuL";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9744-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9744-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E27C3118EF2
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 12:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF92424D41;
	Wed, 15 Jul 2026 12:29:24 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763FB446829
	for <linux-pwm@vger.kernel.org>; Wed, 15 Jul 2026 12:29:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118563; cv=none; b=aT6rAV3Ed3rWYQ3z3xYmInEgSgFIU5xxCGGo6ssdqbyEw4lgJ1efLe/6u68lD6ISA/uNvduJ9p5XFjDOoDWY8kNO+q2T3tCMHjiaOCqbRyeIKRxjVyLuvcEUhmlJ82ymvYz7o4jpC74icTOFDGJlp9O0AiZA1/Hwl793zQ9vwaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118563; c=relaxed/simple;
	bh=nrTsPQFoCtfwAFu3v09MuG+OELfRHAvPanIJna/kovM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9HWXINpjoUL2VTRagEEGtAAjezqO5qRmc2ct10FSuumCy4vCGxirq1RFwtT/+/pABPJRr/gDbCAcYTJPCROI1k/nMtZpMHG/ux0auvdAuvZ/ts7Sk6dycdLMj34LKh75d1McKkYE5HA+yh6qjJ84/vqTTgYzEUvqvMLzq/+VRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/6T1AuL; arc=none smtp.client-ip=209.85.167.41
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b00d1e7082so4082336e87.1
        for <linux-pwm@vger.kernel.org>; Wed, 15 Jul 2026 05:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784118559; x=1784723359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f3K5awkNoDHIG61b2HSqKFDBT2vo7+SdZ5eSrGUkQm0=;
        b=i/6T1AuL4+7M4wD05OtMljRLwCWvUp5SZ7B/UgFvSGHr8QqrireX4013n5n9GUbBu7
         5I5/j1594E9/XkerJpl5hV8WMW74LLzSDNby/hnMj8+NoOKxgSJZ6M050MRSJFumNjyB
         f7xzRK8mR+6eVpaN7sfOietGBqNTTESrmjyDtnyuY7UWLv0VaZP8/pbErklUKUsEAIsT
         QW/+3IgRHmSQ28clL3VEOVvqLoVQ/KSEaSs/QH2+jTozdJbBDhG3LeiahiaMVgSjqMN5
         84Rxr5vj3m9C/JUcjXWC5wWL+eRomFrN+V9gWxAdyYTgUn2tcyIvxfHhuxGFhIi2ckGB
         c2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784118559; x=1784723359;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f3K5awkNoDHIG61b2HSqKFDBT2vo7+SdZ5eSrGUkQm0=;
        b=GtzcUHHUM1IA7xv10QlO89buHi66YyX9XinxdtLUr8Wz1bJ9gi1gCeSIyValbeAZRr
         k+UwWcMzoHDGmzLYx72kopCQ685EBF99uabu6b94oxtTt9/mrooalclTvGJ8YlA8AE7O
         ABs6NgI4IsDf0+cOvsfenYwWnhhwSiuYNzgmy8Y0a7kSx44whMlNzCRsAs0iFJVjUcSM
         7L24kVixgR/Wg4oG/1S1Dr/WAQSkcSCPtigO/3hHG6xKiEuVaZHEzI44FY4foOPg6rfg
         0YyNMEJWLqrvPeEQECc2NohQo6Il628xRk95+9/iQbCWpbeGfDAMkEDJNoFFIiyHBL2Y
         DOhw==
X-Forwarded-Encrypted: i=1; AHgh+RoMVEPbvWjJX1Pco2rXW2gcnGi3jQkVdVGVqKo+kr2u8Y0upSzc6027gbaSSpLcdoe/ecpUUuPvVsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM5AOz/Zjx5UIPh418GxcpGbxnloP6r3Br5V7pNjzwfS2BAzHr
	s2i4qugO9Dj9xWV8+/tZ3RQ8MASHekW5TxBSN5tTOQfDcVQCLU2AVmd+
X-Gm-Gg: AfdE7cnqG/iLg14FSgS5z1xIsQXmTg/f2ExfJoECqdh9dsSOsgkp5S3NF+9i4ez+Ar7
	dTvxL4Tg/hOqV0n92xPLwGwSVC4uuYCKMncPtDVHH/peVX/gp4cowp+JL7YuaYim3bZa9ZJvQsR
	H+A+nCYQtkZjHp+2pC6AMIK47lvM1vRD8avHgSrSbD5bBmypsk0CmERFDqBBkbWb7/C3FbrZr34
	Dn4ZPPs1/AKwuP/F+yWqgwfO/AYYSEGXXIpaNIHpgbY4IOPs0MEIzlDHxHBVZiXARhUyZoEigTe
	37UySZJn9bVg68madehClaRXBIfLU0v177WSFf+1E9K+RaiE9chUjEaA69YU92Zs9FS+qgAUj30
	0TYHx+dQtWO2j0nMFqgEG75Lxli4+1e8HfAjaXXiNxWde6KCBLM7dwdTx8czMIZfNyyx7xgH6Z1
	y7DWkVAVNBJInTLBFHNacZLdeegW4075+5WLijZVCqNsDVAdM4McHGysKt+tLNQQjyz5KNiqBeU
	Bu7p3fUoX7Md+qrSPxbilxBe2OBbJh0DCztZfNDraxhmjYNgpsBFITf0nLfM0SorD91Qrh+f2aV
	zY/98arrBAu0
X-Received: by 2002:a05:6512:3b88:b0:5ae:bba1:f231 with SMTP id 2adb3069b0e04-5b159b6fe60mr1524076e87.17.1784118559013;
        Wed, 15 Jul 2026 05:29:19 -0700 (PDT)
Received: from ola-desktop.tail7f4623.ts.net (184.89-11-176.customer.lyse.net. [89.11.176.184])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01cab1888sm4161884e87.83.2026.07.15.05.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 05:29:18 -0700 (PDT)
From: "Ola Chr. Vaage" <o.c.vage@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	"Ola Chr . Vaage" <o.c.vage@gmail.com>,
	"Ola Chr. Vaage" <ola.christoffer.vage@scoutdi.com>
Subject: Re: [PATCH v1 6/6] pwm: tegra: Implement .get_state()
Date: Wed, 15 Jul 2026 14:28:48 +0200
Message-ID: <20260715122914.2815081-1-o.c.vage@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <33b13f17d7135923d08e2ff40c867803e19609b9.1784030076.git.ukleinek@kernel.org>
References: <33b13f17d7135923d08e2ff40c867803e19609b9.1784030076.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,scoutdi.com];
	TAGGED_FROM(0.00)[bounces-9744-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:thierry.reding@kernel.org,m:jonathanh@nvidia.com,m:mperttunen@nvidia.com,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:o.c.vage@gmail.com,m:ola.christoffer.vage@scoutdi.com,m:ocvage@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ocvage@gmail.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ocvage@gmail.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2971175E2F4
X-Rspamd-Action: no action

Hello Uwe,

On Tue, Jul 14, 2026 at 02:02:40PM +0200, Uwe Kleine-König wrote:
> Subject: [PATCH v1 6/6] pwm: tegra: Implement .get_state()

I tested this on a Jetson Orin NX (Tegra234), the board from my
divider truncation report, driving a fan on the 32a0000 PWM instance.

The board runs NVIDIA's L4T 5.15 kernel, so I backported the patch
onto that tree: .get_state() returns void there, pwmchip_parent(chip)
becomes the driver's device pointer, and the per-SoC enable_reg /
scale_width indirection collapses to the fixed CSR layout (that tree
predates the Tegra264 restructure). The decode logic is unchanged from
your patch. The tree also carries my divider change from the other
thread, which is why the achieved periods in the table differ from
what your base would program.

Procedure: apply a state through the pwm sysfs interface, read the CSR
register and the clock rate independently (/dev/mem and clk_summary),
then unexport/re-export the channel so pwm_device_request() invokes
.get_state(), and compare the reported state against values computed
from the raw register:

  applied period/duty/enabled  readback         computed from CSR+clk
  45334/20000/1                46432/20496/1    46432/20496/1
  500000/250000/1              481883/240942/1  481883/240942/1
  5000/2500/1                  5020/2510/1      5020/2510/1
  45334/45334/1 (100% duty)    46432/46432/1    46432/46432/1
  45334/20000/0                enabled=0        enabled=0

The clock rate varied across the cases (3.19, 11.03 and 102 MHz), so
the scale field was exercised at several values, and the 100% duty
case reads the full 9-bit duty field (pwm0 = 256). The readback
consistently reports the achieved hardware state rather than the
requested one.

One limitation of my backport, not your code: in the disabled case I
only set state->enabled = false instead of zeroing the whole struct,
so I did not verify the period/duty values your version reports for a
disabled channel.

Tested-by: Ola Chr. Vaage <ola.christoffer.vage@scoutdi.com>

Best regards
Ola

