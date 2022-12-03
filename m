Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAB3641312
	for <lists+linux-pwm@lfdr.de>; Sat,  3 Dec 2022 02:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbiLCB4d (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Dec 2022 20:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbiLCB4b (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Dec 2022 20:56:31 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEC2F88B0
        for <linux-pwm@vger.kernel.org>; Fri,  2 Dec 2022 17:56:29 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 463515C0045;
        Fri,  2 Dec 2022 20:56:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 02 Dec 2022 20:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1670032589; x=
        1670118989; bh=gH97yBNlSVx+eynbDATUVjIx5Mx6MG4tobGZMPAZGrA=; b=q
        K/lJjpMHw82Ngty+mLEXBHThZ8aiuFbk0vN1pJUbFfy08lTIv7dJEIcpNX05aNMH
        ivXsYiCow/AiXN4zL/Kar5zQo5g58J8AecrDPXHt0xsQGrGOJlewPBGssuopb7pE
        E9ik7MdoQGEHGDVPiGjUPLyM1eznhn4DetVnD7G1dRvdw4AXJqeYBYma6je3s8SB
        uHYAmvUghVh8gbHYQJgTnDSupybOBrbXHbYpRgKK17G5t7EwSQNI+/bqgO9xLNp8
        DJGxcWOb1B/0kKWR0fPwTCQ0kInmEa5v5fe/dmwGLVPK4lu2tb46xPRUnaNuysIy
        xXIx9NyXud8rcQGrkCrmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1670032589; x=
        1670118989; bh=gH97yBNlSVx+eynbDATUVjIx5Mx6MG4tobGZMPAZGrA=; b=c
        tOO9e3acUElz7inujkR07LYwugsG4zkLp7VeIPDbggexPmvMwpivI3O23FF8To5E
        +PNxetajsEzF61giaidqDikSxieT24rabRnWxHTky6ajDwqEaRHpbaKjAzt9U95v
        d99z+E1AL5/lj5Jmn8iWxe1DSOIgcQPnokGqOmWazENK8T7VfBpQ/yjjrMjBsBMm
        Hl38ZpSmk1Pk1tW3R22UXnL4sHGOH4kYCWQBnBHKSn/87AhfyEQD7U6DJEqeGR5q
        9tyaz5Q6yD3kUNjWMGkPyeN6z4IAQKi4hcVdPDMQa0cMktzP7T0NbdmtDBfDhfTs
        hoqH9kqUTOTdUFsC8f6cg==
X-ME-Sender: <xms:zayKY6H1krVmftxHwC6Pom78_ARc1WbCVE9zc1wjfNabD4IIxJnofA>
    <xme:zayKY7VXo67ALcnyEm3266ilfSNI56Lt0mt1x2VRV5kxw1-CMi71f6JdwWnYSJhGO
    UesC0rBxbRzwK8sYw>
X-ME-Received: <xmr:zayKY0JOleQxmMO80Hg4PrMVXcfiGmn3X4OVDe2_UKHyrR2qcm62jhCWflxKAzgzgLMFz4JjFnnSOBESKObIFApIFGhdi3GoW72WHVF5snLotq6zBoLKrzXVMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdelgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudfhffefhfffuddutedvffekteevieeugeefleelffeitddutdff
    udehgfdtfefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:zayKY0EKnR2iWQuFfR7mqef0Y4Jmj81f3NEw0oR3CSoqM44ys5RAuA>
    <xmx:zayKYwWIQ8EzGZ0AkwQWzgICc0CDFEtsoGxOguh8NFWZ36No7CmImg>
    <xmx:zayKY3MEeDEtGrdS4pXbrJ5Eb1aLM0tQWBrszZdeRNPrdQTf7h7bWQ>
    <xmx:zayKYyIFnZh-jQtJP_84pPzccRXDpmKgutwasJs0gDDaRKx41basVw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Dec 2022 20:56:28 -0500 (EST)
Message-ID: <8f177f68-3e3b-97e8-0f3e-607810623f27@sholland.org>
Date:   Fri, 2 Dec 2022 19:56:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] pwm: sun4i: Propagate errors in .get_state() to the
 caller
Content-Language: en-US
To:     Andre Przywara <andre.przywara@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
References: <20221201152223.3133-1-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20221201152223.3133-1-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 12/1/22 09:22, Andre Przywara wrote:
> .get_state() can return an error indication now. Make use of it to
> propagate an impossible prescaler encoding, should that have sneaked in
> somehow.
> Also check the return value of clk_get_rate(). That's unlikely to fail,
> but we use that in two divide operations down in the code, so let's
> avoid a divide-by-zero condition on the way.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Hi,
> 
> this goes on top of Uwe's series to introduce and observe .get_state
> failures: https://lore.kernel.org/linux-pwm/20221130152148.2769768-12-u.kleine-koenig@pengutronix.de/T/#m9af39aa03bbd9bb7b31b3600f110c65ee0e8e70b
> Actually it only relies on patch 01/11 from that.
> 
> Cheers,
> Andre
> 
>  drivers/pwm/pwm-sun4i.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Samuel Holland <samuel@sholland.org>

