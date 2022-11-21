Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01420632E6D
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Nov 2022 22:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiKUVIB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Nov 2022 16:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiKUVIA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Nov 2022 16:08:00 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B52F1EAC2
        for <linux-pwm@vger.kernel.org>; Mon, 21 Nov 2022 13:07:59 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 49C64377;
        Mon, 21 Nov 2022 21:07:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 49C64377
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1669064876; bh=yCT3qdPFZMMbQpyOfNtkv+ATOSt2TdhUrsnjVpcdEz8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Dh2SOPTCgrXma6eV3275pl6aT2I1xqIvtqXx2TkLA5niucFJWHpSrUEdZxjDo328U
         qq0IcUbeXJGSXTCNZmyw7aJSjlyNbdr/Gm6d/DvmcMQXosJFFZ2JtLinXjLzRG7wOE
         jKcXHFvsOKwwwL+W0LB2JcV7SuGI0znjEYGOJ5EfEZpA+BNMVnGXdhR9Q9bOcA6+o4
         /QnG9ORRB/Jr9I95MtuMztMWD9+nbMz0iS4DmAA0bk6wXnjttwKRVjZvZ6PDY/nqYs
         kAoC6RRPvuOWcYFKhdWeWEN3SUgiDdVCw16cfy70nLgVORTJIpNbnLgvIBEy6tFwdf
         dJKldibQugDcQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] Documentation: devres: add missing PWM helper
In-Reply-To: <20221117115950.mlzkipddy3qwwp2k@pengutronix.de>
References: <20221102024430.1444714-1-yangyingliang@huawei.com>
 <20221117115950.mlzkipddy3qwwp2k@pengutronix.de>
Date:   Mon, 21 Nov 2022 14:07:55 -0700
Message-ID: <87k03o9ftg.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> On Wed, Nov 02, 2022 at 10:44:30AM +0800, Yang Yingliang wrote:
>> Add missing devm_pwmchip_add() to devres.rst. It's introduced by
>> commit bcda91bf86c1 ("pwm: Add a device-managed function to add
>> PWM chips").
>>=20
>> Fixes: bcda91bf86c1 ("pwm: Add a device-managed function to add PWM chip=
s")
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Cc: "Uwe Kleine-K=C3=B6nig" <u.kleine-koenig@pengutronix.de>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>  Documentation/driver-api/driver-model/devres.rst | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Document=
ation/driver-api/driver-model/devres.rst
>> index aac9c1e39ebc..2bea236d6919 100644
>> --- a/Documentation/driver-api/driver-model/devres.rst
>> +++ b/Documentation/driver-api/driver-model/devres.rst
>> @@ -402,6 +402,7 @@ POWER
>>    devm_reboot_mode_unregister()
>>=20=20
>>  PWM
>> +  devm_pwmchip_add()
>>    devm_pwm_get()
>>    devm_fwnode_pwm_get()
>
> Oh, didn't know that doc list.
>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> Is this expected to go via the pwm tree, or will Jonathan pick it up?

I've applied it.

Thanks,

jon
