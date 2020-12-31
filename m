Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CAF2E81D3
	for <lists+linux-pwm@lfdr.de>; Thu, 31 Dec 2020 20:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgLaTcB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 31 Dec 2020 14:32:01 -0500
Received: from mout.gmx.net ([212.227.15.15]:42209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgLaTcB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 31 Dec 2020 14:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609443013;
        bh=UKF3OySAkPzqeKqSrZvgQy1ClJ6Oi8ALLy1iGzX51hw=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:References:Date:In-Reply-To;
        b=igVF7Mh4Ulqn5SQIzcw+O+/KIicDcou2nFqHa6qvZK+lOUx0n9vYvfyn76kb7L6vC
         1xg3Hvnh3Gu+nAOlhaI50g1/XB9MTGJHyXManig3u8uoB5wve5ZQaw3cgujmLgbHra
         z9rpMgisJ2+DiRqya3oy3eaXs9iPR2eR3yER1umU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.51] ([78.42.220.31]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPog5-1khfV80diF-00MwR0; Thu, 31
 Dec 2020 20:30:13 +0100
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH v2] pwm: bcm2835: Improve period and duty cycle
 calculation
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Sean Young <sean@mess.org>
Cc:     linux-pwm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, kernel@pengutronix.de,
        LinoSanfilippo@gmx.de
References: <20201222221319.2101107-1-u.kleine-koenig@pengutronix.de>
Message-ID: <ab77b694-38c7-7f09-d1c0-b8a680ab84a4@gmx.de>
Date:   Thu, 31 Dec 2020 20:30:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201222221319.2101107-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gux4Iog40vE83nM8sgGnZfLoWhljVuwiUVb1bcYt4U4uAPwQi9D
 MSdn8B7uEqp4w68H7nyJfwZ1T2KoicNmTFKGrafdy0yflLhwfSMWwHoac9OoNC5C3nYWy54
 r4acz6yhfj3IXVSNHYdZU30xU9o1twoM374BBIDSd0nurVojA0Acj5ZGzQ5D2FciPq2kzps
 Umu0FWx/nyyifLTXIvnNw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iflRqHqebZM=:XeLxrDyEM2IhMTsmhtXquE
 q7sE47HqjfRqOoGCrPeVTl8W8PMdoYzYtodJp0DYzbF4HcBQVAF9YyJ1cH7dvAlUmunitxCdd
 iGLej1MoA6MDGso86nGs90sglXglPv4eMhAxN9aRX5l/3bdNDKLaKCGQToyQ1Z5d8wSI2rmUA
 nMkmsxLrJaWgmkILtxn+c/BNUvDgK1YZ+i7/LpKVJEfzTbb4bpLRAGgyitPRu5XLy9e/1odIl
 VpNea6LL2inipEWv7ZBnaQzzxKQKVV4hOV+pDpDos0fBaP05hZgSO66nq3wJnAzqaEjrtBKbq
 VBe1EZFL8R79HK2+1jE3PBk2Byl6UZ7cFbqEiUdjCysY9UsylGEFKWTYYmTkGSLIgWCqadzKJ
 4J0HkRMOFHy27sqzybGJZmZ0zA+LdRZssFw5d+4AX3sfcWYYeWu02zvcxe+wGZp3YWBWqarnM
 TXIs2T8RxgTixzM7uGc38fFfqVcrc+6333ssUQAePaLSM2o2A5CMnl4jxfZqNfvj25Rc9bxcz
 WgNOry97Y560QdxHk9olksUy1MaS5KL46PBsYTd6Ynkmm/u7ofw+qhLB9es9bCC7GPXokyEyu
 j6hb6YtzHU+iFpwbE4OlzibZ+KFyvhO29rjEOcoL/PK6JNpkMWr9TIrCedKjQ7A6voV0yJm+4
 /4rmhP7bEM+aREaHXf7fZJD+SlQgYMpxRBNhGWkxqCooki6CgtGeFKDgQ7nG+mGGrAcViyNxk
 cOw90/pI8i9H4Ib9ngpN3/1tvWKRKXCMrG9nCuvvSFbcSdMvIJmKNKNJfstoyYalNIxT7vOOp
 95ehi//xm6+DPnX6OD0yX5EsH7hNw+la/5E5KcMuYuI/7fsB8DYBAPpYDoG7esncpm0wVasoJ
 FvKhQoMoYGNabHKDrGRQ==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

just some nitpicks (maybe only worth fixing if there will be a v3 for othe=
r reasons):

On 22.12.20 at 23:13, Uwe Kleine-K=C3=B6nig wrote:

> +	/*
> +	 * period_cycles must be a 32 bit value, so period * rate / NSEC_PER_S=
EC
> +	 * must be <=3D U32_MAX. As U32_MAX * NSEC_PER_SEC < U64_MAX the
> +	 * multiplication period * rate doesn't overflow.
> +	 */
> +	max_period =3D DIV_ROUND_UP_ULL((u64)U32_MAX * NSEC_PER_SEC + NSEC_PER=
_SEC / 2, rate) - 1;

For someone looking at the formula it might be helpful to also have an exp=
lanation for the added
term "+ NSEC_PER_SEC / 2" in the comment. This line also exeeds the 80 cha=
rs limit...


> +	period_cycles =3D DIV_ROUND_CLOSEST_ULL(state->period * rate, NSEC_PER=
_SEC);

...as well as this line.

Regards,
Lino



