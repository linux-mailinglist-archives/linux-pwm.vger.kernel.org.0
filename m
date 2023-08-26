Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702C57898D7
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Aug 2023 21:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjHZTyh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 26 Aug 2023 15:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHZTyN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 26 Aug 2023 15:54:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A299E1;
        Sat, 26 Aug 2023 12:54:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E911361DDC;
        Sat, 26 Aug 2023 19:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7869BC433C7;
        Sat, 26 Aug 2023 19:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693079650;
        bh=nrSynCHxDoLZn3/pLs5NkoedjZd+pj8AeN8iwDjdDXE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Rdxp8Osv9y0mdymS4j5R47dk4eR6QGc9T0cNnnLiJxTNGmJAIwoQ2SRZqDTmBLOmB
         flperzSlg+r+WzhGqhutZebR3/UZTZr8q1/ZeynPbQ2PyjvNh6WzUMSDQyCAUnRs+i
         a324z1EPzpEWKNPUVmMJPXTPIalJBXoXR/CPtvvfLkKRfYS7KHdBRVEl68VMJIb/rW
         Sitf+vclndxZcTu8d0SnvrcB7PVPfnkUzdpRXiRRLamaW9EtZ7oshQ+MqeMTnMF8Ma
         EUSARBatJE2dcfLjB5p3WuzQ2QfInxQgHbvGgZXZfVHdiqZ4/g+7zHxEGcmnW4TKnW
         a0fxAmMUnxfGQ==
Message-ID: <2b81baae-cd50-e46f-f560-33b3d186cb24@kernel.org>
Date:   Sat, 26 Aug 2023 21:54:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 2/2] dt-bindings: media: remove nokia,n900-ir as
 pwm-ir-tx is compatible
To:     Sean Young <sean@mess.org>, linux-media@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Timo Kokkonen <timo.t.kokkonen@iki.fi>
References: <20230826171711.366710-1-sean@mess.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230826171711.366710-1-sean@mess.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 26/08/2023 19:17, Sean Young wrote:
> The generic pwm-ir-tx driver works for the Nokia n900, so nokia,n900-ir
> can be removed.
> 
> Signed-off-by: Sean Young <sean@mess.org>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time.

Please kindly resend and include all necessary To/Cc entries.

Best regards,
Krzysztof

