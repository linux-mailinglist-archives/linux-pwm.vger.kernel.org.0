Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255C1219C1E
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2020 11:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgGIJ1K (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Jul 2020 05:27:10 -0400
Received: from a27-192.smtp-out.us-west-2.amazonses.com ([54.240.27.192]:59488
        "EHLO a27-192.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726435AbgGIJ1I (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Jul 2020 05:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=7jvkchcrhflv7qhbkgrcypyraifp65wy; d=rt.linuxfoundation.org;
        t=1594286827;
        h=Subject:From:Reply-To:In-Reply-To:References:Message-ID:CC:Content-Type:Date:MIME-Version:Content-Transfer-Encoding;
        bh=QHwfDWTLFLpGTStJ912tPrbIWjoghNOp6EjBvx7KpUk=;
        b=aePth7DiwcjZdPBDWA67X2hmGwkU+mMRNzUI7G10Oz7Egd+mEGM7gFYWq0oi6Xhl
        /AvtoH+JwQrFiL7qB6pUZ3hmMIuDHT+u8UQo9br60mDwbaen47dLa+zxsQ+hOJYFpCJ
        rWz6x2zckc3WesFmZQOynj4i7e9BHg4F5+lFm1pU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1594286827;
        h=Subject:From:Reply-To:In-Reply-To:References:Message-ID:CC:Content-Type:Date:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=QHwfDWTLFLpGTStJ912tPrbIWjoghNOp6EjBvx7KpUk=;
        b=QVDtNhDZmi2Cqm6BnQc/PIy1FPe992cT378D1w+dr9XMYGAnGzSt4LRhwJchtB/A
        E6JIatgK+TiAgdw+W3pWG/3gs0d+2z5jsXQ8zqG5u2Ee9cgtU9H8G1bFd1XwCXu3zpL
        OQgsD6oZF5dkdwqdkzJZwT11IVUYsZlGG5fXnslE=
Subject: [Kernel.org Helpdesk #89942] [linuxfoundation.org #89942] Re: adding linux-pwm archives to lore.kernel.org?
From:   "=?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= via RT" 
        <kernel-helpdesk@rt.linuxfoundation.org>
Reply-To: kernel-helpdesk@rt.linuxfoundation.org
In-Reply-To: <20200709092659.drrmvv53qs2q4lid@pengutronix.de>
References: <RT-Ticket-89942@linuxfoundation>
 <20200213102618.x5j6kfvqmdbx2pr2@pengutronix.de>
 <20200523170558.h2brqlf2jx4kee6y@pengutronix.de>
 <20200613141533.ak3nyo5hu636evwq@taurus.defre.kleine-koenig.org>
 <20200709092659.drrmvv53qs2q4lid@pengutronix.de>
Message-ID: <0101017332e666c2-77af3c9c-623d-434e-bd9e-16bfb225efba-000000@us-west-2.amazonses.com>
X-RT-Loop-Prevention: linuxfoundation.org
X-RT-Ticket: linuxfoundation.org #89942
X-Managed-BY: RT 4.4.0 (http://www.bestpractical.com/rt/)
X-RT-Originator: u.kleine-koenig@pengutronix.de
CC:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com
X-RT-Original-Encoding: utf-8
Content-Type: multipart/mixed; boundary="----------=_1594286826-1686-1383"
Date:   Thu, 9 Jul 2020 09:27:07 +0000
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2020.07.09-54.240.27.192
Feedback-ID: 1.us-west-2.3ULHQnc20aILdVzjlbQ8UqO1WRWzA1U01b2uFAcT62w=:AmazonSES
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1594286826-1686-1383
Content-Type: text/plain; charset="utf-8"

Hello Konstantin(?),

On Sat, Jun 13, 2020 at 04:15:33PM +0200, Uwe Kleine-König wrote:
> On Sat, May 23, 2020 at 07:05:58PM +0200, Uwe Kleine-König wrote:
> > On Thu, Feb 13, 2020 at 11:26:18AM +0100, Uwe Kleine-König wrote:
> > > I consider the archives on lore.kernel.org very useful and would like to
> > > see the linux-pwm list archived there, too.
> > > 
> > > Assuming you agree (or at least don't disagree) we'd need to follow
> > > https://korg.wiki.kernel.org/userdoc/lore. Therefor we need an archive
> > > of the already sent mails. My personal archive only goes back to Oct
> > > 2018, so I guess I'm not in the best position to provide it. But I can
> > > nevertheless care for the buerocratics and start with my archive given
> > > that I get some support from someone with a more complete archive.
> > > 
> > > What do you think?
> > 
> > I didn't get feedback from Thierry (= linux-pwm maintainer) but I still
> > think adding linux-pwm to kernel.org's public-inbox instance is
> > valuable. (And if it's only to experiment with b4.)
> 
> In the meantime Thierry said to support the idea to get the linux-pwm
> list archived on lore.kernel.org and also provide his archive for the
> initial population.
> 
> I assume you're OK in principle to archive linux-pwm and it's "just" a
> matter of lacking time to work on getting this list up and running on
> lore.k.o? Is there anything we can do to simplify the things for you?

Do you get my mail? Is there some problem with the request, or is it
just -ENOTIME on your end? Would it help to already initialize a public
inbox v2 repository?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |


------------=_1594286826-1686-1383
Content-Type: application/x-rt-original-message
Content-Disposition: inline
Content-Transfer-Encoding: base64
RT-Attachment: 89942/2020468/1689175

RnJvbSBTUlMwPWZYdjQ9QVU9cGVuZ3V0cm9uaXguZGU9dWtsQGtlcm5lbC5v
cmcgIFRodSBKdWwgIDkgMDk6Mjc6MDEgMjAyMApSZXR1cm4tUGF0aDogPFNS
UzA9Zlh2ND1BVT1wZW5ndXRyb25peC5kZT11a2xAa2VybmVsLm9yZz4KWC1P
cmlnaW5hbC1Ubzoga2VybmVsLWhlbHBkZXNrQHJ0LmxpbnV4Zm91bmRhdGlv
bi5vcmcKRGVsaXZlcmVkLVRvOiBrZXJuZWwtaGVscGRlc2tAcnQubGludXhm
b3VuZGF0aW9uLm9yZwpSZWNlaXZlZDogZnJvbSBtYWlsLmtlcm5lbC5vcmcg
KG1haWwua2VybmVsLm9yZyBbMTk4LjE0NS4yOS45OV0pCglieSBhd3MtdXMt
d2VzdC0yLWxmaXQtcnQtMS53ZWIuY29kZWF1cm9yYS5vcmcgKFBvc3RmaXgp
IHdpdGggRVNNVFAgaWQgREZGNTRDNDMzQ0IKCWZvciA8a2VybmVsLWhlbHBk
ZXNrQHJ0LmxpbnV4Zm91bmRhdGlvbi5vcmc+OyBUaHUsICA5IEp1bCAyMDIw
IDA5OjI3OjAxICswMDAwIChVVEMpClJlY2VpdmVkOiBieSBtYWlsLmtlcm5l
bC5vcmcgKFBvc3RmaXgpCglpZCA4RTgzRDIwNjYzOyBUaHUsICA5IEp1bCAy
MDIwIDA5OjI3OjAxICswMDAwIChVVEMpCkRlbGl2ZXJlZC1UbzogaGVscGRl
c2tAa2VybmVsLm9yZwpSZWNlaXZlZDogZnJvbSBtZXRpcy5leHQucGVuZ3V0
cm9uaXguZGUgKG1ldGlzLmV4dC5wZW5ndXRyb25peC5kZSBbODUuMjIwLjE2
NS43MV0pCgkodXNpbmcgVExTdjEuMiB3aXRoIGNpcGhlciBFQ0RIRS1SU0Et
QUVTMjU2LUdDTS1TSEEzODQgKDI1Ni8yNTYgYml0cykpCgkoTm8gY2xpZW50
IGNlcnRpZmljYXRlIHJlcXVlc3RlZCkKCWJ5IG1haWwua2VybmVsLm9yZyAo
UG9zdGZpeCkgd2l0aCBFU01UUFMgaWQgMzlBNzIyMDc2QQoJZm9yIDxoZWxw
ZGVza0BrZXJuZWwub3JnPjsgVGh1LCAgOSBKdWwgMjAyMCAwOToyNzowMSAr
MDAwMCAoVVRDKQpETUFSQy1GaWx0ZXI6IE9wZW5ETUFSQyBGaWx0ZXIgdjEu
My4yIG1haWwua2VybmVsLm9yZyAzOUE3MjIwNzZBCkF1dGhlbnRpY2F0aW9u
LVJlc3VsdHM6IG1haWwua2VybmVsLm9yZzsgZG1hcmM9bm9uZSAocD1ub25l
IGRpcz1ub25lKSBoZWFkZXIuZnJvbT1wZW5ndXRyb25peC5kZQpBdXRoZW50
aWNhdGlvbi1SZXN1bHRzOiBtYWlsLmtlcm5lbC5vcmc7IHNwZj1wYXNzIHNt
dHAubWFpbGZyb209dWtsQHBlbmd1dHJvbml4LmRlClJlY2VpdmVkOiBmcm9t
IHB0eS5oaS5wZW5ndXRyb25peC5kZSAoWzIwMDE6NjdjOjY3MDoxMDA6MWQ6
OmM1XSkKCWJ5IG1ldGlzLmV4dC5wZW5ndXRyb25peC5kZSB3aXRoIGVzbXRw
cyAoVExTMS4yOkVDREhFX1JTQV9BRVNfMjU2X0dDTV9TSEEzODQ6MjU2KQoJ
KEV4aW0gNC45MikKCShlbnZlbG9wZS1mcm9tIDx1a2xAcGVuZ3V0cm9uaXgu
ZGU+KQoJaWQgMWp0U3BYLTAwMDVEOC1PaTsgVGh1LCAwOSBKdWwgMjAyMCAx
MToyNjo1OSArMDIwMApSZWNlaXZlZDogZnJvbSB1a2wgYnkgcHR5LmhpLnBl
bmd1dHJvbml4LmRlIHdpdGggbG9jYWwgKEV4aW0gNC44OSkKCShlbnZlbG9w
ZS1mcm9tIDx1a2xAcGVuZ3V0cm9uaXguZGU+KQoJaWQgMWp0U3BYLTAwMDgx
SS1FajsgVGh1LCAwOSBKdWwgMjAyMCAxMToyNjo1OSArMDIwMApEYXRlOiBU
aHUsIDkgSnVsIDIwMjAgMTE6MjY6NTkgKzAyMDAKRnJvbTogVXdlID0/dXRm
LTg/UT9LbGVpbmUtSz1DMz1CNm5pZz89IDx1LmtsZWluZS1rb2VuaWdAcGVu
Z3V0cm9uaXguZGU+ClRvOiBoZWxwZGVza0BrZXJuZWwub3JnCkNjOiBsaW51
eC1wd21Admdlci5rZXJuZWwub3JnLCBUaGllcnJ5IFJlZGluZyA8dGhpZXJy
eS5yZWRpbmdAZ21haWwuY29tPgpTdWJqZWN0OiBSZTogYWRkaW5nIGxpbnV4
LXB3bSBhcmNoaXZlcyB0byBsb3JlLmtlcm5lbC5vcmc/Ck1lc3NhZ2UtSUQ6
IDwyMDIwMDcwOTA5MjY1OS5kcnJtdnY1M3FzMnE0bGlkQHBlbmd1dHJvbml4
LmRlPgpSZWZlcmVuY2VzOiA8MjAyMDAyMTMxMDI2MTgueDVqNmtmdnFtZGJ4
MnByMkBwZW5ndXRyb25peC5kZT4KIDwyMDIwMDUyMzE3MDU1OC5oMmJycWxm
Mmp4NGtlZTZ5QHBlbmd1dHJvbml4LmRlPgogPDIwMjAwNjEzMTQxNTMzLmFr
M255bzVodTYzNmV2d3FAdGF1cnVzLmRlZnJlLmtsZWluZS1rb2VuaWcub3Jn
PgpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IG11bHRpcGFydC9z
aWduZWQ7IG1pY2FsZz1wZ3Atc2hhNTEyOwoJcHJvdG9jb2w9ImFwcGxpY2F0
aW9uL3BncC1zaWduYXR1cmUiOyBib3VuZGFyeT0ibzI2c2V5b3U3eWQyYTZv
ayIKQ29udGVudC1EaXNwb3NpdGlvbjogaW5saW5lCkluLVJlcGx5LVRvOiA8
MjAyMDA2MTMxNDE1MzMuYWszbnlvNWh1NjM2ZXZ3cUB0YXVydXMuZGVmcmUu
a2xlaW5lLWtvZW5pZy5vcmc+ClgtU0EtRXhpbS1Db25uZWN0LUlQOiAyMDAx
OjY3Yzo2NzA6MTAwOjFkOjpjNQpYLVNBLUV4aW0tTWFpbC1Gcm9tOiB1a2xA
cGVuZ3V0cm9uaXguZGUKWC1TQS1FeGltLVNjYW5uZWQ6IE5vIChvbiBtZXRp
cy5leHQucGVuZ3V0cm9uaXguZGUpOyBTQUV4aW1SdW5Db25kIGV4cGFuZGVk
IHRvIGZhbHNlClgtUFRYLU9yaWdpbmFsLVJlY2lwaWVudDogaGVscGRlc2tA
a2VybmVsLm9yZwoKCi0tbzI2c2V5b3U3eWQyYTZvawpDb250ZW50LVR5cGU6
IHRleHQvcGxhaW47IGNoYXJzZXQ9aXNvLTg4NTktMQpDb250ZW50LURpc3Bv
c2l0aW9uOiBpbmxpbmUKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogcXVv
dGVkLXByaW50YWJsZQoKSGVsbG8gS29uc3RhbnRpbig/KSwKCk9uIFNhdCwg
SnVuIDEzLCAyMDIwIGF0IDA0OjE1OjMzUE0gKzAyMDAsIFV3ZSBLbGVpbmUt
Sz1GNm5pZyB3cm90ZToKPiBPbiBTYXQsIE1heSAyMywgMjAyMCBhdCAwNzow
NTo1OFBNICswMjAwLCBVd2UgS2xlaW5lLUs9RjZuaWcgd3JvdGU6Cj4gPiBP
biBUaHUsIEZlYiAxMywgMjAyMCBhdCAxMToyNjoxOEFNICswMTAwLCBVd2Ug
S2xlaW5lLUs9RjZuaWcgd3JvdGU6Cj4gPiA+IEkgY29uc2lkZXIgdGhlIGFy
Y2hpdmVzIG9uIGxvcmUua2VybmVsLm9yZyB2ZXJ5IHVzZWZ1bCBhbmQgd291
bGQgbGlrZT0KIHRvCj4gPiA+IHNlZSB0aGUgbGludXgtcHdtIGxpc3QgYXJj
aGl2ZWQgdGhlcmUsIHRvby4KPiA+ID49MjAKPiA+ID4gQXNzdW1pbmcgeW91
IGFncmVlIChvciBhdCBsZWFzdCBkb24ndCBkaXNhZ3JlZSkgd2UnZCBuZWVk
IHRvIGZvbGxvdwo+ID4gPiBodHRwczovL2tvcmcud2lraS5rZXJuZWwub3Jn
L3VzZXJkb2MvbG9yZS4gVGhlcmVmb3Igd2UgbmVlZCBhbiBhcmNoaXZlCj4g
PiA+IG9mIHRoZSBhbHJlYWR5IHNlbnQgbWFpbHMuIE15IHBlcnNvbmFsIGFy
Y2hpdmUgb25seSBnb2VzIGJhY2sgdG8gT2N0Cj4gPiA+IDIwMTgsIHNvIEkg
Z3Vlc3MgSSdtIG5vdCBpbiB0aGUgYmVzdCBwb3NpdGlvbiB0byBwcm92aWRl
IGl0LiBCdXQgSSBjYW4KPiA+ID4gbmV2ZXJ0aGVsZXNzIGNhcmUgZm9yIHRo
ZSBidWVyb2NyYXRpY3MgYW5kIHN0YXJ0IHdpdGggbXkgYXJjaGl2ZSBnaXZl
bgo+ID4gPiB0aGF0IEkgZ2V0IHNvbWUgc3VwcG9ydCBmcm9tIHNvbWVvbmUg
d2l0aCBhIG1vcmUgY29tcGxldGUgYXJjaGl2ZS4KPiA+ID49MjAKPiA+ID4g
V2hhdCBkbyB5b3UgdGhpbms/Cj4gPj0yMAo+ID4gSSBkaWRuJ3QgZ2V0IGZl
ZWRiYWNrIGZyb20gVGhpZXJyeSAoPTNEIGxpbnV4LXB3bSBtYWludGFpbmVy
KSBidXQgSSBzdGk9CmxsCj4gPiB0aGluayBhZGRpbmcgbGludXgtcHdtIHRv
IGtlcm5lbC5vcmcncyBwdWJsaWMtaW5ib3ggaW5zdGFuY2UgaXMKPiA+IHZh
bHVhYmxlLiAoQW5kIGlmIGl0J3Mgb25seSB0byBleHBlcmltZW50IHdpdGgg
YjQuKQo+PTIwCj4gSW4gdGhlIG1lYW50aW1lIFRoaWVycnkgc2FpZCB0byBz
dXBwb3J0IHRoZSBpZGVhIHRvIGdldCB0aGUgbGludXgtcHdtCj4gbGlzdCBh
cmNoaXZlZCBvbiBsb3JlLmtlcm5lbC5vcmcgYW5kIGFsc28gcHJvdmlkZSBo
aXMgYXJjaGl2ZSBmb3IgdGhlCj4gaW5pdGlhbCBwb3B1bGF0aW9uLgo+PTIw
Cj4gSSBhc3N1bWUgeW91J3JlIE9LIGluIHByaW5jaXBsZSB0byBhcmNoaXZl
IGxpbnV4LXB3bSBhbmQgaXQncyAianVzdCIgYQo+IG1hdHRlciBvZiBsYWNr
aW5nIHRpbWUgdG8gd29yayBvbiBnZXR0aW5nIHRoaXMgbGlzdCB1cCBhbmQg
cnVubmluZyBvbgo+IGxvcmUuay5vPyBJcyB0aGVyZSBhbnl0aGluZyB3ZSBj
YW4gZG8gdG8gc2ltcGxpZnkgdGhlIHRoaW5ncyBmb3IgeW91PwoKRG8geW91
IGdldCBteSBtYWlsPyBJcyB0aGVyZSBzb21lIHByb2JsZW0gd2l0aCB0aGUg
cmVxdWVzdCwgb3IgaXMgaXQKanVzdCAtRU5PVElNRSBvbiB5b3VyIGVuZD8g
V291bGQgaXQgaGVscCB0byBhbHJlYWR5IGluaXRpYWxpemUgYSBwdWJsaWMK
aW5ib3ggdjIgcmVwb3NpdG9yeT8KCkJlc3QgcmVnYXJkcwpVd2UKCi0tPTIw
ClBlbmd1dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgICAgICAgICAgICB8
IFV3ZSBLbGVpbmUtSz1GNm5pZyAgICAgICAgICAgIHwKSW5kdXN0cmlhbCBM
aW51eCBTb2x1dGlvbnMgICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cu
cGVuZ3V0cm9uaXguZGUvIHwKCi0tbzI2c2V5b3U3eWQyYTZvawpDb250ZW50
LVR5cGU6IGFwcGxpY2F0aW9uL3BncC1zaWduYXR1cmU7IG5hbWU9InNpZ25h
dHVyZS5hc2MiCgotLS0tLUJFR0lOIFBHUCBTSUdOQVRVUkUtLS0tLQoKaVFF
ekJBQUJDZ0FkRmlFRWZuSXFGcEFZclA4K2RLUUx3ZndVZUszSzdBa0ZBbDhH
NHVBQUNna1F3ZndVZUszSwo3QWwyT3dmL1JFRWZ6bm56dGplekxrU2FrNnFK
aCtSRFpmdThaNStoNEw2NFhBb3JXTHViV2cyeWFMTXFvdzVSCnRicEd0VXp3
WEM3dVlrMjEreHd6R2U4QmtGblBwa3YrelM4bnhzeExHNk9udmc1U3VqV1dl
LzhpbzBidVBndWIKdTdYQXRnSUwzTEM0WUdzTThIeER1WGFrY2N6eVhhQ28y
SGNFN0hmT2lKbHd1UWlhQjRwYy9keHE1ZGtkMUsxMgpjZjkydUVhYk1qaFpC
MDl4N2M0MTJ2QkJCbHQ2L2VPQVlEcXZ5K3VzK2o4MHBkRjRYV1dQMDFmNXJO
NW0rQitKCk1tSGdmN3J3Z0E2bXFHblplcG45QVpNN2kyR1d0dTIzbkRmOXpz
eEtaTEx1MWkyTzlIT0ZKQmZjQ0RUZjUvVzcKWGFTaFIySlR1bzRKMG1Raks3
Y3JCVTdUSnNBc3p3PT0KPWU2Q2IKLS0tLS1FTkQgUEdQIFNJR05BVFVSRS0t
LS0tCgotLW8yNnNleW91N3lkMmE2b2stLQo=

------------=_1594286826-1686-1383--
