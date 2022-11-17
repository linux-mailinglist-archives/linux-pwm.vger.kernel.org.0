Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DDD62DD93
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Nov 2022 15:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239766AbiKQOJ3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Nov 2022 09:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239819AbiKQOJ2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Nov 2022 09:09:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BD964555
        for <linux-pwm@vger.kernel.org>; Thu, 17 Nov 2022 06:09:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C278861E4C
        for <linux-pwm@vger.kernel.org>; Thu, 17 Nov 2022 14:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAF1C4347C
        for <linux-pwm@vger.kernel.org>; Thu, 17 Nov 2022 14:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668694165;
        bh=kFf1BlsqbF1snd//p2/5Vu67tJrV3hvqaTBuSJNFgvI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mboiqzYSv3Rx3DUZ/wncnUqNB+B/B5RZbn4qWafuoclv73FZ7k1sTs/k6gVyjoxcl
         dU9ygRV3Yz/jlFZVp+LHg7zvxw5VVt0iovApN9NUI0v8tR3y72OO2ubZQwsdjiI+sR
         e2qPNtDQNK62CuUmRrt635M42eMLg/PGX1xikcMn4Sa641e07MNeY7+D2HwnDf1f5n
         R7W80ggvJzNpCOyllUn9Ow1HfrnQyx8l1Pcdt4crNgxTEhj950sE17CQY8nWdDR+0H
         TdNSzWR04/A5ei3VGVtU7LIESqw7LdXFB3eL3ffv+QkwFU6ErHhRWoPkjbzCI1GAE8
         glbW1kCKzL3YQ==
Received: by mail-lj1-f178.google.com with SMTP id u11so2835382ljk.6
        for <linux-pwm@vger.kernel.org>; Thu, 17 Nov 2022 06:09:25 -0800 (PST)
X-Gm-Message-State: ANoB5pn0rwUaWX0dvTXjsmn49AtIiFOB6FBzDNUKHgPGPrlQotVSoB48
        gc9vw9Cy8/N0g6ECTu8Ks7jHN4DrAI4UFgOb8A==
X-Google-Smtp-Source: AA0mqf5l2P0RRR5SLIW4f3fCD4PvOX7KfiHWNX0OJEbN7B90KmsUZ14+NJybDy2pQp4UqdK2cHuOu7VD0n9MGdhrnB0=
X-Received: by 2002:a05:651c:2328:b0:277:14cf:6da2 with SMTP id
 bi40-20020a05651c232800b0027714cf6da2mr1021629ljb.94.1668694163167; Thu, 17
 Nov 2022 06:09:23 -0800 (PST)
MIME-Version: 1.0
References: <20221117083111.1260643-1-Naresh.Solanki@9elements.com> <20221117091803.zy42s3qd5bo4r6et@pengutronix.de>
In-Reply-To: <20221117091803.zy42s3qd5bo4r6et@pengutronix.de>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 17 Nov 2022 08:09:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLQ2Q2XGTxSjCi8nWqFVTURViDUrZMWKHUHp1CNyL+bbQ@mail.gmail.com>
Message-ID: <CAL_JsqLQ2Q2XGTxSjCi8nWqFVTURViDUrZMWKHUHp1CNyL+bbQ@mail.gmail.com>
Subject: Re: [PATCH v2] pwm: core: Do not create device link for same consumer
 & supplier
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Nov 17, 2022 at 3:18 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Thu, Nov 17, 2022 at 09:31:11AM +0100, Naresh Solanki wrote:
> > If the PWM consumer is the child DT device of PWM supplier, i.e., the
> > same 'struct device' then do not create device link.
> >
> > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>
> In a private conversation I learned that this is needed for
> https://lore.kernel.org/all/20221116213615.1256297-1-Naresh.Solanki@9elem=
ents.com/
>
> Given the series above is broken without this patch, I suggest to
> discuss these in a single series.
>
> I still think the provider shouldn't consume it's own PWM. Either the
> PWM is usable for other purposes, then it should be a proper device on
> its own, or it isn't and then please don't expose it.

TBC, none of this should affect the binding because this is all kernel
implementation decisions. In the binding, the consumer is a proper
device (node).

Unless there's some automatic h/w feedback controlling the pwm, the
fan controller needs to do normal PWM control like any other client.
Not exposing as a PWM means reimplementing everything the PWM
subsystem does including parsing the pwms properties itself. That
doesn't seem great. Long term, perhaps there should be fan driver(s)
separate from a fan controller.

Rob
